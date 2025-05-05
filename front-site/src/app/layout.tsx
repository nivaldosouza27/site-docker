import type { Metadata } from "next";
import { Suspense } from "react";
import "../styles/globals.css";
import Loading from "./loading";
import { Providers } from "./providers";

export const metadata: Metadata = {
  title: "Site Adulto UP-X",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html suppressHydrationWarning lang="pt-BR">
      <Suspense fallback={<Loading />} />
      <body>
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
