Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id A21EFDE02C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 22:00:41 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so3627226pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 05:00:39 -0700 (PDT)
Subject: Re: [U-Boot-Users] AMCC PPC440EPx/sequoia stability question...
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200804240636.12349.sr@denx.de>
References: <480EADF4.2020706@verizon.net> <200804231449.24746.sr@denx.de>
	<1208999427.2946.8.camel@vader.jdub.homelinux.org>
	<200804240636.12349.sr@denx.de>
Content-Type: text/plain
Date: Thu, 24 Apr 2008 07:00:06 -0500
Message-Id: <1209038406.2946.20.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2008-04-24 at 06:36 +0200, Stefan Roese wrote:
> On Thursday 24 April 2008, Josh Boyer wrote:
> > > Please note that I recently introduced a CFG_MEM_TOP_HIDE option for the
> > > 440EPx CHIP 11 errata. I suggest you take a look at this too and see if
> > > this changes your behavior.
> >
> > Explain this a bit more please?  Is a kernel change needed here?
> 
> This depends. When the bootwrapper version is used then yes, the kernel should 
> get changed. This is because the bootwrapper detects the SDRAM size from the 
> DDR2 controller and passes it to Linux.
> 
> Without bootwrapper no changes are needed, since U-Boot already passes the 
> corrected memory size to Linux (totalsize-4k currently).

Hm.  Given that AMCC ships the boards with an older U-Boot that requires
cuImages, I think we'll need to patch the wrapper.  Does 440GRx share
this same errata?  I would think so.

josh
