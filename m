Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 885942BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Dec 2004 05:05:47 +1100 (EST)
Date: Fri, 3 Dec 2004 11:05:45 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
Message-ID: <20041203110545.A25168@home.com>
References: <45ABD2373C33C4459D42B40EC4F346F2047DC3D4@FTWMLVEM03.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45ABD2373C33C4459D42B40EC4F346F2047DC3D4@FTWMLVEM03.e2k.ad.ge.com>;
	from Renaud.Barbier@ge.com on Fri, Dec 03, 2004 at 06:12:31AM -0600
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 440GX MMU problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Dec 03, 2004 at 06:12:31AM -0600, Barbier, Renaud (GE Infrastructure) wrote:
> 
> I am using linux 2.4.26 on a 440GX with 512MB of SDRAM.
> >From U-boot I can see the whole memory.
> If I boot Linux, unless I set the boot parameter mem=256M (or less).
> it will not boot. Linux does not seem to go further than the MMU_setup.

Verified that the 440GX eval with 512MB works on both 2.4.26 and current
2.4. Works For Me(tm).
 
> Any idea why it cannot use 512MB?

A broken board port would do it. If you deviate for any reason
from the stock kernel configuration you can shoot yourself in the
foot real fast. If you can provide some details on your custom
board and port, somebody may be able to help you.

-Matt
