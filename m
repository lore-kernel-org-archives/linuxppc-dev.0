Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 814CEDDF0C
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 22:44:27 +1000 (EST)
In-Reply-To: <20070530080526.36115DDFC8@ozlabs.org>
References: <20070530080526.36115DDFC8@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AB7DD12D-76D5-43D8-90BF-904C7C85205E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH 2/4] powerpc: ptrace can set DABR on both 32 and 64
	bits
Date: Wed, 30 May 2007 07:44:18 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, ulrich.weigand@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 30, 2007, at 3:05 AM, Benjamin Herrenschmidt wrote:

> Allow ptrace to set dabr in the thread structure for both 32 and 64  
> bits,
> though only 64 bits actually uses that field, it's actually defined  
> in both.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Can you make these -EIO for CONFIG_BOOKE for now.

- k
