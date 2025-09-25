'use client'

import { useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { useAuthStore } from '@/store/auth'

export default function DashboardPage() {
  const router = useRouter()
  const { user, isAuthenticated, logout } = useAuthStore()

  useEffect(() => {
    if (!isAuthenticated) {
      router.push('/auth')
    }
  }, [isAuthenticated, router])

  const handleLogout = () => {
    logout()
    router.push('/auth')
  }

  if (!isAuthenticated || !user) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-primary mx-auto"></div>
          <p className="mt-4 text-muted-foreground">Carregando dashboard...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary/5 via-background to-secondary/5">
      {/* Header */}
      <header className="border-b bg-card/95 backdrop-blur supports-[backdrop-filter]:bg-card/60">
        <div className="container mx-auto px-4 py-3 flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-bold text-primary">RoomMate Manager</h1>
            <p className="text-sm text-muted-foreground">Bem-vindo, {user.name}!</p>
          </div>
          <Button variant="outline" onClick={handleLogout}>
            Sair
          </Button>
        </div>
      </header>

      {/* Main Content */}
      <main className="container mx-auto px-4 py-8">
        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
          {/* Welcome Card */}
          <Card className="md:col-span-2 lg:col-span-3">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                🏠 Dashboard - Funcionalidade em Desenvolvimento
              </CardTitle>
              <CardDescription>
                Esta é a primeira feature implementada: Autenticação (login/registro)
              </CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="p-4 bg-primary/5 rounded-lg border border-primary/20">
                <h3 className="font-semibold text-primary mb-2">✅ Funcionalidades Implementadas:</h3>
                <ul className="space-y-1 text-sm">
                  <li>• Sistema de autenticação com login e registro</li>
                  <li>• Validação de formulários em tempo real</li>
                  <li>• State management com Zustand</li>
                  <li>• Design system com shadcn/ui</li>
                  <li>• Suporte a cores com opacidade (ex: text-primary/50)</li>
                  <li>• Navegação automática baseada no estado de autenticação</li>
                </ul>
              </div>

              <div className="p-4 bg-warning/5 rounded-lg border border-warning/20">
                <h3 className="font-semibold text-warning mb-2">⏳ Próximas Features:</h3>
                <ul className="space-y-1 text-sm">
                  <li>• Dashboard com resumo de despesas</li>
                  <li>• Gerenciamento de despesas compartilhadas</li>
                  <li>• Lista de compras colaborativa</li>
                  <li>• Galeria de recibos</li>
                  <li>• Integração com a API Rails backend</li>
                </ul>
              </div>

              <div className="flex flex-wrap gap-2">
                <Button variant="outline" disabled>
                  💰 Adicionar Despesa (Em breve)
                </Button>
                <Button variant="outline" disabled>
                  🛒 Lista de Compras (Em breve)
                </Button>
                <Button variant="outline" disabled>
                  📄 Recibos (Em breve)
                </Button>
              </div>
            </CardContent>
          </Card>

          {/* User Info Card */}
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">👤 Informações do Usuário</CardTitle>
            </CardHeader>
            <CardContent className="space-y-2">
              <div className="flex justify-between">
                <span className="text-muted-foreground">Nome:</span>
                <span className="font-medium">{user.name}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-muted-foreground">Email:</span>
                <span className="font-medium">{user.email}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-muted-foreground">ID:</span>
                <span className="font-mono text-sm">#{user.id}</span>
              </div>
            </CardContent>
          </Card>

          {/* Status Card */}
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">⚡ Status do Sistema</CardTitle>
            </CardHeader>
            <CardContent className="space-y-2">
              <div className="flex items-center justify-between">
                <span className="text-muted-foreground">Frontend:</span>
                <div className="flex items-center gap-2">
                  <div className="w-2 h-2 bg-success rounded-full"></div>
                  <span className="text-sm font-medium">Ativo</span>
                </div>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-muted-foreground">Backend API:</span>
                <div className="flex items-center gap-2">
                  <div className="w-2 h-2 bg-warning rounded-full"></div>
                  <span className="text-sm font-medium">Pendente</span>
                </div>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-muted-foreground">Autenticação:</span>
                <div className="flex items-center gap-2">
                  <div className="w-2 h-2 bg-success rounded-full"></div>
                  <span className="text-sm font-medium">Funcionando</span>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </main>
    </div>
  )
}