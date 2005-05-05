Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 24F3C67AC7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 00:03:19 +1000 (EST)
In-Reply-To: <42797FDE.7080909@ybb.ne.jp>
References: <42797FDE.7080909@ybb.ne.jp>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <905bacf60cf1e3167d4f42dba31c9d4f@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 5 May 2005 09:02:58 -0500
To: "Takeharu KATO" <takeharu1219@ybb.ne.jp>
Cc: Glenn Burkhardt <glenn@aoi-industries.com>,
	"Gala Kumar K.-galak" <galak@freescale.com>, linuxppc-embedded@ozlabs.org
Subject: Re: PPC 44x Watchdog timer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 4, 2005, at 9:07 PM, Takeharu KATO wrote:

> Hi
>
> Glenn Burkhardt wrote:
>
> > watchdog exception interrupt isn't used, and it's only configurable 
> for
> > PPC405 (although I think that the technique would work for the whole 
> 4xx
> > family).
>  >
> > Or am I misreading the code?
>  >
> No, the kernel which I mentioned before is MontaVistaLinux.
> IIRC, I look the WDT relevant codes in MontaVistaLinux2.X few years 
> ago.
> Of course, It was prepared for PowerPC40X...
>
> > It would also be nice if your patch were applied to the 2.6 kernel 
> tree.
> >
> Sorry, It's not my jurisdiction.
> Matt(Porter) or Kumar(Gala) may be responsible for this work.
>  #Finally, the patch should be approved by akpm and linus, of course...
>
> Matt or Kumar, would you merge BOOKE_WDT patch to 2.6 kernel tree?
>  IIRC, This patch has been left under review state about two month.
>  Is there something to be needed for the patch?

Sorry, I think Matt and I have been busy with normal "work".  I'll take 
a look at this in the next week.  If you can update the patches to 
something current that would help (but is not critical).

thanks
- kumar
