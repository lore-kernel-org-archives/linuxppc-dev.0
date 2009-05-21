Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB373DE1B2
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 00:47:23 +1000 (EST)
Message-Id: <27AB6AE2-F8BA-4F05-9597-BCE0F98C1126@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Morrison, Tom" <tmorrison@empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D90110F53A79@EMPBEDEX.empirix.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: How to debug a hung multi-core system....
Date: Thu, 21 May 2009 09:45:13 -0500
References: <BD261180E6D35F4D9D32F3E44FD3D90110EFACB2@EMPBEDEX.empirix.com>
	<C966FFF1-23FD-4581-A001-79F6961F8E49@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110F53A79@EMPBEDEX.empirix.com>
Cc: Geary Sean-R60898 <sean.geary@freescale.com>, linuxppc-dev@ozlabs.org,
	"Young, Andrew" <andrew.young@windriver.com>, "Brown,
	Jeff" <jbrown@empirix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> [Morrison, Tom]
> >BKM>tat
>
> Entry  EPN          RPN    TID  TMASK   WIMGE  TSIZ U0:3  X0:1    
> PID  TS  PROT SHEN   UR   UW   UX   SR   SW   SX  TIDZ VAL
>

> LT0  C0000000     00000000 00     0FF     04     9     0     0      
> 0    0    P    P    E    E    D    E    E    D    D    V
> LT1  D0000000     01000000 00     0FF     04     9     0     0      
> 0    0    P    P    E    E    D    E    E    D    D    V
> LT2  E0000000     02000000 00     0FF     04     9     0     0      
> 0    0    P    P    E    E    D    E    E    D    D    V

> LT4  F924E000     7C054500 BA     000     0B     E     0     3      
> 0    0    P    S    E    E    D    E    E    D    D    V

> LT6  80000000     1F000000 F2     0FF     1D     9     B     3      
> 0    0    U    S    D    E    D    E    E    E    D    V
> LT7  64000000     1F000000 B3     07F     02     8     B     0      
> 0    1    U    S    D    E    D    D    E    E    D    V
> LT8  E5BF1000     995EA900 96     000     0C     D     8     0      
> 0    1    U    S    D    E    E    E    E    D    D    V

> LT11 6B000000     F5700000 BC     03F     04     7     D     0      
> 0    1    P    S    E    E    E    E    E    E    D    V
> LT12 712DB000     F1B59100 2A     000     19     C     F     1      
> 0    1    P    S    E    E    E    E    D    E    D    V
> LT13 00000000     F0000000 7F     0FF     07     B     0     0      
> 0    1    P    S    D    D    E    E    E    E    D    V
> LT14 A3000000     FDD00000 C5     03F     16     7     E     3      
> 0    1    P    S    E    E    E    D    D    E    D    V
> LT15 F7F00000     B0B80000 82     00F     1F     5     F     0      
> 0    1    P    P    E    E    D    D    D    D    D    V

Do you know what the Entry field means?  Are you guys putting your own  
mappings into the TLB?  LT4..LT15 (with VAL = V) seem very odd to me.

- k
