Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id E89EA67A67
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Mar 2005 08:02:33 +1100 (EST)
Date: Tue, 1 Mar 2005 14:02:27 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050301140226.C24061@cox.net>
References: <c3d0340b05022310396240c8ac@mail.gmail.com>
	<20050223142426.B13087@cox.net>
	<c3d0340b05022413437aa5b729@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b05022413437aa5b729@mail.gmail.com>;
	from shawnxjin@gmail.com on Thu, Feb 24, 2005 at 01:43:57PM -0800
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Ebony's UBoot awareness
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 24, 2005 at 01:43:57PM -0800, Shawn Jin wrote:
> Hi Matt,
> 
> > Can you use the ocotea/luan approach and create an openbios stub
> > in arch/ppc/boot to create the bi_enetaddr infos? The PIBS stub
> > in arch/ppc/boot does this so we can have one path in the platform
> > file that parses the bootinfos.
> 
> I'd like to help if I can follow you. What does PIBS stand for? What
> is the ocotea/luan approach you were talking about? I thought I
> followed the ocotea approach to set up mac addresses.

FYI, the implementation by Gerhard Jaeger for OpenBIOS/U-Boot
Ebony support was sent upstream.
 
-Matt
