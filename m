Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0349DDFC2
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 20:22:33 +1100 (EST)
Date: Fri, 21 Mar 2008 04:18:46 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: crash in init_ipic_sysfs on efika
In-Reply-To: <18403.31214.826941.838442@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0803210418170.8073@blarg.am.freescale.net>
References: <20080317195305.GA13298@aepfle.de>
	<fa686aa40803202214k7d8596a5y922a34f33d33dca2@mail.gmail.com>
	<18403.31214.826941.838442@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 21 Mar 2008, Paul Mackerras wrote:

> Grant Likely writes:
>
> > Confirmed, this patch fixes the problem.  Paulus or Kumar, can you
> > please pick it up for .25?
>
> Sure, will do.  I thought about putting it in the last batch but I
> wanted an ack from you.
>
> Anyone else got any last-minute things for 2.6.25?

since you are going to send something to linus let me update the fsl
defconfigs and send you a pull request.

- k
