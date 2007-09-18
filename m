Return-Path: <rwoodworth@securics.com>
Received: from securics.com (dns.securics.com [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id BB03CDDF87
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 07:14:32 +1000 (EST)
Subject: Re: Xilinx FX60
From: Robert Woodworth <rwoodworth@securics.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40709181402s633b6946k685a0bffe8bb7c10@mail.gmail.com>
References: <1190149090.7268.29.camel@PisteOff>
	<fa686aa40709181402s633b6946k685a0bffe8bb7c10@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 18 Sep 2007 15:14:30 -0600
Message-Id: <1190150070.7268.34.camel@PisteOff>
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

On Tue, 2007-09-18 at 15:02 -0600, Grant Likely wrote:
> >
> > The only difference is that the FX60 board only has 32MB DDR, I have
> > made sure that the correct memory size is in the kernel.
> 
> How are you booting your kernel?  .ace? u-boot? load via debugger?

load via debugger (Xilinx xmd)

FYI: the board I'm using is the
TB-4V-FX60
http://www.hitechglobal.com/TED/V4PowerPC.htm

> Cheers,
> g.
> 
