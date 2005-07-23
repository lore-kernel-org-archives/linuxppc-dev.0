Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id 4D93667D9B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Jul 2005 01:13:58 +1000 (EST)
Date: Sat, 23 Jul 2005 07:30:22 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Grant Likely <glikely@gmail.com>
Message-ID: <20050723073022.A5431@cox.net>
References: <528646bc050723070419b8f914@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc050723070419b8f914@mail.gmail.com>;
	from glikely@gmail.com on Sat, Jul 23, 2005 at 10:04:07AM -0400
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 0/3] Support for SPI busses and devices
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Jul 23, 2005 at 10:04:07AM -0400, Grant Likely wrote:
> Request for Comment:
> 
> Here is a set of patches that adds SPI support to linux.  I'm looking
> for feedback on these and I'd like to eventually get the SPI
> infrastructure into mainline

There is also another attempt at an SPI subsystem (not based on the RMK
code) that was posted to lkml.  You might want to check out
http://lkml.org/lkml/2005/5/31/162 for the original posting and
then an updated version at http://lkml.org/lkml/2005/6/23/161

-Matt
