Return-Path: <dedekind1@gmail.com>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BBE96B6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 15:31:41 +1000 (EST)
Received: by pvg18 with SMTP id 18so310465pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jun 2011 22:31:38 -0700 (PDT)
Subject: Re: [PATCH] powerpc/85xx: fix NAND_CMD_READID read bytes number
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Date: Wed, 22 Jun 2011 08:32:20 +0300
In-Reply-To: <1307931792-30386-1-git-send-email-Shaohui.Xie@freescale.com>
References: <1307931792-30386-1-git-send-email-Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308720745.18119.32.camel@sauron>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linux-mtd@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-06-13 at 10:23 +0800, Shaohui Xie wrote:
> when nand_get_flash_type() is called, it will read 8 bytes of ID instead of 5,
> but the driver only read 5 bytes, so kernel will dump error messages like:
> 
> fsl-lbc ffe124000.localbus: read_byte beyond end of buffer
> fsl-lbc ffe124000.localbus: read_byte beyond end of buffer
> fsl-lbc ffe124000.localbus: read_byte beyond end of buffer
> 

Thanks!

-- 
Best Regards,
Artem Bityutskiy
