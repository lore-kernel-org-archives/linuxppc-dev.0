Return-Path: <dedekind1@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4B78B6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 17:22:20 +1000 (EST)
Received: by iyn35 with SMTP id 35so6510251iyn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 06 Jul 2011 00:22:17 -0700 (PDT)
Subject: Re: [PATCH v3] mtd: eLBC NAND: remove elbc_fcm_ctrl->oob_poi
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Matthew L. Creech" <mlcreech@gmail.com>
Date: Wed, 06 Jul 2011 10:23:13 +0300
In-Reply-To: <1309907688-8235-1-git-send-email-mlcreech@gmail.com>
References: <1309905302-1990-1-git-send-email-mlcreech@gmail.com>
	<1309907688-8235-1-git-send-email-mlcreech@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1309937003.3149.83.camel@sauron>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org, mhench@elutions.com, rick22@wi.rr.com
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-07-05 at 19:14 -0400, Matthew L. Creech wrote:
> From: Mike Hench <mhench@elutions.com>
> 
> The eLBC NAND driver currently follows up each program/write operation with a
> read-back of the page, in order to [ostensibly] fill in ECC data for the
> caller. However, the page address used for this read is always -1, so the read
> will never work correctly.  Remove this useless (and potentially problematic)
> block of code.

Pushed to l2-mtd-2.6.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
