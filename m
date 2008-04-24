Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id E8771DDF13
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 11:10:31 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so3376949pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 18:10:30 -0700 (PDT)
Subject: Re: [U-Boot-Users] AMCC PPC440EPx/sequoia stability question...
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200804231449.24746.sr@denx.de>
References: <480EADF4.2020706@verizon.net>  <200804231449.24746.sr@denx.de>
Content-Type: text/plain
Date: Wed, 23 Apr 2008 20:10:27 -0500
Message-Id: <1208999427.2946.8.camel@vader.jdub.homelinux.org>
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

On Wed, 2008-04-23 at 14:49 +0200, Stefan Roese wrote:
> On Wednesday 23 April 2008, Dave Littell wrote:
> > At this point all possibilities are on the table and I'm looking for any
> > input from anyone with experience (good, bad, or whatever) with this
> > processor and/or designs similar to the Sequoia.
> 
> If you scan the U-Boot mailing list for 440EPx/Denali DDR2 problems, you will 
> most likely find some references.
> 
> Please note that I recently introduced a CFG_MEM_TOP_HIDE option for the 
> 440EPx CHIP 11 errata. I suggest you take a look at this too and see if this 
> changes your behavior.

Explain this a bit more please?  Is a kernel change needed here?

josh
