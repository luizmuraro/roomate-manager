import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

// Brazilian currency formatting
export function formatBrazilianCurrency(amount: number): string {
  return new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  }).format(amount)
}

// Brazilian date formatting
export function formatBrazilianDate(date: string | Date): string {
  return new Intl.DateTimeFormat('pt-BR').format(new Date(date))
}

// Brazilian date time formatting
export function formatBrazilianDateTime(date: string | Date): string {
  return new Intl.DateTimeFormat('pt-BR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  }).format(new Date(date))
}

// Category emoji mapping
export function getCategoryEmoji(category: string): string {
  const emojiMap: Record<string, string> = {
    groceries: '🛒',
    utilities: '💡',
    household: '🏠',
    transport: '🚗',
    entertainment: '🎬',
    healthcare: '🏥',
    other: '📄',
    // Shopping categories
    produce: '🥬',
    dairy: '🥛',
    meat: '🍖',
    pantry: '📦'
  }
  return emojiMap[category] || '📄'
}