import { ReactNode } from "react";

interface IProviderProps {
  children: ReactNode;
}

const Providers = ({ children }: IProviderProps) => {
  return <div>{children}</div>;
};

export { Providers };
