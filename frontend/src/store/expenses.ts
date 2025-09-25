import { create } from 'zustand'
import { Expense } from '@/types'

interface ExpensesState {
  expenses: Expense[]
  isLoading: boolean
  error: string | null
  currentPage: number
  totalPages: number
  filters: {
    category?: string
    status?: string
    search?: string
    dateFrom?: string
    dateTo?: string
  }

  // Actions
  fetchExpenses: (page?: number) => Promise<void>
  addExpense: (expense: Omit<Expense, 'id' | 'date' | 'user' | 'roommate'>) => Promise<boolean>
  updateExpense: (id: number, updates: Partial<Expense>) => Promise<boolean>
  deleteExpense: (id: number) => Promise<boolean>
  settleExpense: (id: number) => Promise<boolean>
  setFilters: (filters: ExpensesState['filters']) => void
  clearFilters: () => void
  clearError: () => void
}

export const useExpensesStore = create<ExpensesState>((set, get) => ({
  expenses: [],
  isLoading: false,
  error: null,
  currentPage: 1,
  totalPages: 1,
  filters: {},

  fetchExpenses: async (page = 1) => {
    set({ isLoading: true, error: null })

    try {
      const { filters } = get()
      const queryParams = new URLSearchParams({
        page: page.toString(),
        per_page: '20',
        ...filters,
      })

      // TODO: Replace with actual API call
      const response = await fetch(`/api/v1/expenses?${queryParams}`, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`,
        },
      })

      if (!response.ok) {
        throw new Error('Failed to fetch expenses')
      }

      const data = await response.json()

      set({
        expenses: data.expenses || [],
        currentPage: data.pagination?.current_page || 1,
        totalPages: data.pagination?.total_pages || 1,
        isLoading: false,
        error: null,
      })
    } catch (error) {
      set({
        error: error instanceof Error ? error.message : 'Failed to fetch expenses',
        isLoading: false,
      })
    }
  },

  addExpense: async (expenseData) => {
    set({ isLoading: true, error: null })

    try {
      // TODO: Replace with actual API call
      const response = await fetch('/api/v1/expenses', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`,
        },
        body: JSON.stringify({ expense: expenseData }),
      })

      if (!response.ok) {
        throw new Error('Failed to add expense')
      }

      const newExpense = await response.json()

      set((state) => ({
        expenses: [newExpense, ...state.expenses],
        isLoading: false,
        error: null,
      }))

      return true
    } catch (error) {
      set({
        error: error instanceof Error ? error.message : 'Failed to add expense',
        isLoading: false,
      })
      return false
    }
  },

  updateExpense: async (id, updates) => {
    set({ isLoading: true, error: null })

    try {
      // TODO: Replace with actual API call
      const response = await fetch(`/api/v1/expenses/${id}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`,
        },
        body: JSON.stringify({ expense: updates }),
      })

      if (!response.ok) {
        throw new Error('Failed to update expense')
      }

      const updatedExpense = await response.json()

      set((state) => ({
        expenses: state.expenses.map((expense) =>
          expense.id === id ? updatedExpense : expense
        ),
        isLoading: false,
        error: null,
      }))

      return true
    } catch (error) {
      set({
        error: error instanceof Error ? error.message : 'Failed to update expense',
        isLoading: false,
      })
      return false
    }
  },

  deleteExpense: async (id) => {
    set({ isLoading: true, error: null })

    try {
      // TODO: Replace with actual API call
      const response = await fetch(`/api/v1/expenses/${id}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('auth-token')}`,
        },
      })

      if (!response.ok) {
        throw new Error('Failed to delete expense')
      }

      set((state) => ({
        expenses: state.expenses.filter((expense) => expense.id !== id),
        isLoading: false,
        error: null,
      }))

      return true
    } catch (error) {
      set({
        error: error instanceof Error ? error.message : 'Failed to delete expense',
        isLoading: false,
      })
      return false
    }
  },

  settleExpense: async (id) => {
    return get().updateExpense(id, { status: 'settled' })
  },

  setFilters: (filters) => {
    set((state) => ({
      filters: { ...state.filters, ...filters },
    }))
    // Automatically refetch with new filters
    get().fetchExpenses(1)
  },

  clearFilters: () => {
    set({ filters: {} })
    get().fetchExpenses(1)
  },

  clearError: () => {
    set({ error: null })
  },
}))