Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6EC712C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 May 2013 07:43:09 +1000 (EST)
In-Reply-To: <OFFA9C9591.71B67D7B-ON85257B60.00808C43-85257B60.0080BB77@us.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <OFFA9C9591.71B67D7B-ON85257B60.00808C43-85257B60.0080BB77@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F9243D77-AF55-4F7B-88B9-C9811347CF4A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR,
 EBB and ISEL bits in HWCAP2
Date: Sat, 4 May 2013 23:42:51 +0200
To: Michael R Meissner <mrmeissn@us.ibm.com>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>, Peter Bergner <bergner@us.ibm.com>,
 Ryan Arnold <ryanarn@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> According to the GCC sources, ISEL is enabled by default for the  
> 8540, 8548, e500mc, e500mc64, e6500 processors.

And e5500.  POWER7 is said to support it as well.


Segher
