// User types
export interface User {
  id: number
  name: string
  email: string
  created_at: string
}

// Expense types
export interface Expense {
  id: number
  description: string
  amount: {
    raw: number
    formatted: string
  }
  category: 'groceries' | 'utilities' | 'household' | 'transport' | 'entertainment' | 'healthcare' | 'other'
  status: 'pending' | 'settled'
  date: string
  user: User
  roommate: User
  settled_at?: string
  settled_by?: {
    id: number
    name: string
  }
}

// Shopping Item types
export interface ShoppingItem {
  id: number
  name: string
  category: 'produce' | 'dairy' | 'meat' | 'household' | 'pantry' | 'other'
  completed: boolean
  created_at: string
  user: User
  roommate: User
}

// Receipt types
export interface Receipt {
  id: number
  title: string
  amount: {
    raw: number
    formatted: string
  }
  category: 'groceries' | 'utilities' | 'household' | 'transport' | 'entertainment' | 'healthcare' | 'other'
  status: 'unprocessed' | 'linked' | 'archived'
  date: string
  image_url?: string
  linked_to_expense: boolean
  expense?: Expense
  user: User
}

// API Response types
export interface PaginationResponse {
  current_page: number
  per_page: number
  total_pages: number
  total_count: number
  next_page?: number
  prev_page?: number
}

export interface ApiResponse<T> {
  data: T
  pagination?: PaginationResponse
}

// Authentication types
export interface LoginCredentials {
  email: string
  password: string
}

export interface RegisterCredentials {
  name: string
  email: string
  password: string
  password_confirmation: string
}

export interface AuthResponse {
  user: User
  token: string
}

// API Error types
export interface ApiError {
  error?: string
  errors?: string[] | Record<string, string[]>
  message?: string
}