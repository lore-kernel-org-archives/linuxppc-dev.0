Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id E34672BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Dec 2004 05:08:38 +1100 (EST)
Date: Fri, 3 Dec 2004 11:08:36 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
Message-ID: <20041203110836.B25168@home.com>
References: <45ABD2373C33C4459D42B40EC4F346F20482F5DA@FTWMLVEM03.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45ABD2373C33C4459D42B40EC4F346F20482F5DA@FTWMLVEM03.e2k.ad.ge.com>;
	from Renaud.Barbier@ge.com on Fri, Dec 03, 2004 at 11:45:25AM -0600
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

On Fri, Dec 03, 2004 at 11:45:25AM -0600, Barbier, Renaud (GE Infrastructure) wrote:
> the memory test from U-boot does not complain as well as vxWorks.
> 
> I will do my own test anyway.

>From experience, these simple memory tests are often not
sufficient...i.e. they can pass even with incorrect timing.

-Matt
