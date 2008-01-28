Return-Path: <rwoodworth@securics.com>
Received: from securics.com (mail.securics.com [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id AA00CDDEFA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jan 2008 02:51:10 +1100 (EST)
Subject: Re: Load Kernel 2.6 using U-boot on ML403
From: Robert Woodworth <rwoodworth@securics.com>
To: Yedu Jathavedan <yeduj@ece.pdx.edu>
In-Reply-To: <20080127202502.zte3h0yr4s44ooc8@webmail.cecs.pdx.edu>
References: <20080126231047.y3lm7epb0gw4cog8@webmail.cecs.pdx.edu>
	<fa686aa40801271313y4370ac3dmd4460d79362f10c4@mail.gmail.com>
	<20080127202502.zte3h0yr4s44ooc8@webmail.cecs.pdx.edu>
Content-Type: text/plain
Date: Mon, 28 Jan 2008 08:51:09 -0700
Message-Id: <1201535469.4734.6.camel@PisteOff>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If you're starting a new design, I *highly* recommend using EDK9.2 with
MPMC3 and LL_TEMAC.

Using the Wizard in EDK9.2 and using the kernel from git.xilinx.com
everything will work fine out-of-the-box.  Including the ethernet.

I've had troubles with the older (EDK9.1) TEMAC and GigE switches not
syncing correctly.   The LL_TEMAC in EDK9.2 solved this issue.



RJW.



On Sun, 2008-01-27 at 20:25 -0800, Yedu Jathavedan wrote:
> >
> > Looking at your bootlog, it doesn't look like you've got the systemace
> > driver built into the kernel.
> >
> >
> Grant,
> 
> Yes, the systemace was not built into the kernel. It is successfully  
> booting the kernel now.
> Trying to bring up the Ethernet interface. Any pointers?
> 
> Thank you,
> Yedu
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
