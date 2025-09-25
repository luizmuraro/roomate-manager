import * as React from "react"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

const badgeVariants = cva(
  "inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2",
  {
    variants: {
      variant: {
        default:
          "border-transparent bg-primary text-primary-foreground hover:bg-primary/80",
        secondary:
          "border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80",
        destructive:
          "border-transparent bg-destructive text-destructive-foreground hover:bg-destructive/80",
        outline: "text-foreground",
        success:
          "border-transparent bg-success text-success-foreground hover:bg-success/80",
        warning:
          "border-transparent bg-warning text-warning-foreground hover:bg-warning/80",
        // Category specific variants for expense management
        groceries:
          "border-transparent bg-blue-100 text-blue-800 hover:bg-blue-100/80",
        utilities:
          "border-transparent bg-yellow-100 text-yellow-800 hover:bg-yellow-100/80",
        household:
          "border-transparent bg-green-100 text-green-800 hover:bg-green-100/80",
        transport:
          "border-transparent bg-purple-100 text-purple-800 hover:bg-purple-100/80",
        entertainment:
          "border-transparent bg-pink-100 text-pink-800 hover:bg-pink-100/80",
        healthcare:
          "border-transparent bg-red-100 text-red-800 hover:bg-red-100/80",
        other:
          "border-transparent bg-gray-100 text-gray-800 hover:bg-gray-100/80",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  }
)

export interface BadgeProps
  extends React.HTMLAttributes<HTMLDivElement>,
    VariantProps<typeof badgeVariants> {}

function Badge({ className, variant, ...props }: BadgeProps) {
  return (
    <div className={cn(badgeVariants({ variant }), className)} {...props} />
  )
}

export { Badge, badgeVariants }