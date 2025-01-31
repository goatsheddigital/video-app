// useContract.ts

import { useWeb3React } from '@web3-react/core';
import { ethers } from 'ethers';
import { useEffect, useState } from 'react';
import { BskyAgent } from '@atproto/api';
import { Contract } from 'ethers';
import { abi } from '../abi';

export const useContract = () => {
  const { library } = useWeb3React();
  const [contract, setContract] = useState<Contract | null>(null);

  useEffect(() => {
    if (!library) {
      return;
    }

    const signer = library.getSigner();
    const contract = new ethers.Contract(
      process.env.NEXT_PUBLIC_CONTRACT_ADDRESS,
      abi,
      signer,
    );

    setContract(contract);
  }, [library]);

  return {
    contract,
  };
};