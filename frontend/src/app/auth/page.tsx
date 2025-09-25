'use client'

import { useState } from 'react'
import { LoginForm } from '@/components/features/auth/login-form'
import { RegisterForm } from '@/components/features/auth/register-form'

export default function AuthPage() {
  const [isLogin, setIsLogin] = useState(true)

  const toggleForm = () => {
    setIsLogin(!isLogin)
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary/5 via-background to-secondary/5 flex items-center justify-center p-4">
      <div className="w-full max-w-md space-y-6">
        {isLogin ? (
          <LoginForm onToggleForm={toggleForm} />
        ) : (
          <RegisterForm onToggleForm={toggleForm} />
        )}

        <div className="text-center text-xs text-muted-foreground">
          <p>Gerenciamento colaborativo de despesas para companheiros de quarto</p>
          <p className="mt-1">Divida contas, organize gastos, mantenha o equilíbrio</p>
        </div>
      </div>
    </div>
  )
}