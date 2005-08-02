Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 827A667D95
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 03:36:22 +1000 (EST)
Date: Tue, 2 Aug 2005 10:35:29 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Wolfgang Denk <wd@denx.de>
Message-ID: <20050802173529.GB6563@mag.az.mvista.com>
References: <A9DE2BAF233E444FA9C5E77A5825A01E8652FA@ydmail.sbell.com.cn>
	<20050802071522.AE98C353BF9@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050802071522.AE98C353BF9@atlas.denx.de>
Cc: FCG WANG Baohua <Baohua.WANG@alcatel-sbell.com.cn>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Reply: Bad Magic Number when boot linux kernel with ppcboot
	(PPC860 board)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 02, 2005 at 09:15:22AM +0200, Wolfgang Denk wrote:
> In message <A9DE2BAF233E444FA9C5E77A5825A01E8652FA@ydmail.sbell.com.cn> you wrote:
> > 
> > => bootm 0x180000
> > ## Booting image at 00000000 ...
> > Bad Magic Number
> > =>
> 
> The funny thing is that you seem to enter "0x180000" but the  address
> printed  is  00000000.  make  sure  you  have  no funny characters or
> control keys in this number. Re-type  it  carefully.  Omit  the  "0x"
> part, i. e. try a plain "bootm 180000'

Plus, use 'bootm' for a .uboot file, 'bootelf' for a zImage.
