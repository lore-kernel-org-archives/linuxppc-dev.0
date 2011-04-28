Return-Path: <dedekind1@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 430C4B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Apr 2011 03:12:48 +1000 (EST)
Received: by ewy6 with SMTP id 6so992736ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Apr 2011 10:12:42 -0700 (PDT)
Subject: Re: [PATCH] powerpc/44x: Add multiple chip select support to NDFC
	driver
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Felix Radensky <felix@embedded-sol.com>
In-Reply-To: <1303810606-2068-1-git-send-email-felix@embedded-sol.com>
References: <1303810606-2068-1-git-send-email-felix@embedded-sol.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Apr 2011 20:08:26 +0300
Message-ID: <1304010506.2737.0.camel@localhost>
Mime-Version: 1.0
Cc: linux-mtd@lists.infradead.org, sr@denx.de, linuxppc-dev@lists.ozlabs.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-04-26 at 12:36 +0300, Felix Radensky wrote:
> This patch extends NDFC driver to support all 4 chip selects
> available in NDFC NAND controller. Tested on custom 460EX board
> with 2 chip select NAND device.
> 
> Signed-off-by: Felix Radensky <felix@embedded-sol.com>
> ---
> 
> I'd appreciate some testing on 44x boards with multiple NAND
> devices, like bamboo or DU440, as I don't have access to these 
> boards.
> 
>  drivers/mtd/nand/ndfc.c |   52 +++++++++++++++++++++++++++++++---------------
>  1 files changed, 35 insertions(+), 17 deletions(-)

Pushed to l2-mtd-2.6.git, thanks.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
