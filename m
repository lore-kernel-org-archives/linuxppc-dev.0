Return-Path: <gjalt007@chello.nl>
Received: from amsfep14-int.chello.nl (amsfep17-int.chello.nl [213.46.243.15])
	by ozlabs.org (Postfix) with ESMTP id 2B6CF67BAB
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  3 Sep 2006 21:28:36 +1000 (EST)
Message-ID: <44FAB757.3000801@chello.nl>
Date: Sun, 03 Sep 2006 13:07:03 +0200
From: Theo Gjaltema <gjalt007@chello.nl>
MIME-Version: 1.0
To: Stephen Williams <steve@icarus.com>,  linuxppc-embedded@ozlabs.org
Subject: Re: Choices of 2.4 Kernel for PPC
References: <e2b1fi$klf$1@sea.gmane.org>
In-Reply-To: <e2b1fi$klf$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Stephen Williams schreef:
> I'd been using the BK tree (I know, old old) but it's been stable
> for me for a while. But I'm starting to see so problems and I want
> to work with a recent kernel tree. I'm using a PPC405GPr processor.
>
> I downloaded the linux-2.4.32 tree from kernel.org, but it has
> none of the Xilinx stuff so I immediately wonder about other things
> it lacks for embedded PPC.
>
> I downloaded the linux 2.4 .git tree from Denx, but the makefile
> in top says it's based on 2.4.25, which is even older then what
> I've got now.
>
> I've looked on the penguinppc.org page, but it points me back
> to the kernel.org distribution and possibly the bk repository.
> Hmm...
>
> So what tree is most universally accepted as current so far as
> embedded PPC goes? And can the penguinppc.org pages be updated
> to reflect the consensus?
>   
I've run into the same problems with the kernel.org version of the linux 
kernel 2.4.32.
the fec_enet module for the ppc was 0.3 instead of 0.4 (denx 2.4.25) and 
the config.in file did not contain any of the physical driver info.
Apart from this the generated kernel crashed when accessing the flash, 
this worked fine in the denx 2.4.25 kernel as well.
We decided that the kernel.org 2.4.32 is not suitable for the ppc and 
stick to the 2.4.25 version as present in the ELDK3.1.1.

Succes,
   Theo Gjaltema.
