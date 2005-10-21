Return-Path: <pantelis.antoniou@gmail.com>
Received: from qproxy.gmail.com (qproxy.gmail.com [72.14.204.192])
	by ozlabs.org (Postfix) with ESMTP id B1C0E68654
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Oct 2005 03:20:32 +1000 (EST)
Received: by qproxy.gmail.com with SMTP id q18so353391qba
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 10:20:30 -0700 (PDT)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 21 Oct 2005 20:18:57 +0300
References: <4358DD4C.7020507@cpe.fr>
	<B6774C27-2E9C-4660-8D5C-4EBE5FEF698D@freescale.com>
In-Reply-To: <B6774C27-2E9C-4660-8D5C-4EBE5FEF698D@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510212018.58334.pantelis.antoniou@gmail.com>
Cc: Nathael PAJANI <nathael.pajani@cpe.fr>
Subject: Re: Three-Speed Ethernet support on MPC8560 (TSEC)
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 21 October 2005 16:39, Kumar Gala wrote:
> 
> On Oct 21, 2005, at 7:21 AM, Nathael PAJANI wrote:
> 
> > Hi all!
> >
> > I'm working on a port of linux (2.6.13-2) on an Actis-computer board,
> > based on the Freescale MPC8560 Processor.
> >
> > I solved the problems I had with the init process, and I actually have
> > the console (SCC1) and one ethernet controler (FCC3) running.
> >
> > I will now go on with the Three-Speed Ethernet Controler, and there
> > actually seem to be no support for it, but maybe I did not look at the
> > right place?
> 
> The TSEC has been supported for a long time.  The driver is call  
> gianfar (drivers/net/gianfar*).
> 
> > I got another question, about the FCC driver: it uses a "big"  
> > structure
> > "fcc_enet_t" wich seems to be aimed at stats. This is initialised,  
> > but I
> > did not find where this is used. Is it?
> 
> The FCC enet driver has been completely rewritten recently and is in  
> the process of being accepted into the kernel.  Hopefully one of the  
> guys with more knowledge on the details will be able to help you on  
> the specifics.
>

fcc_enet_t is in the CPM parameter area. It is used but the statistics
it provides are not, since we properly update the linux net device stats
manually.
 
> - kumar
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

Regards

Pantelis
