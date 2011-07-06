Return-Path: <dedekind1@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 82648B6F76
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jul 2011 16:45:38 +1000 (EST)
Received: by iwn36 with SMTP id 36so7140665iwn.15
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Jul 2011 23:45:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] mtd/nand : don't free the global data
	fsl_lbc_ctrl_dev->nand in fsl_elbc_chip_remove()
From: Artem Bityutskiy <dedekind1@gmail.com>
To: b35362@freescale.com
Date: Wed, 06 Jul 2011 09:46:34 +0300
In-Reply-To: <1309225852-1664-1-git-send-email-b35362@freescale.com>
References: <1309225852-1664-1-git-send-email-b35362@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1309934799.3149.69.camel@sauron>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-06-28 at 09:50 +0800, b35362@freescale.com wrote:
> From: Liu Shuo <b35362@freescale.com>
> 
> The global data fsl_lbc_ctrl_dev->nand don't have to be freed in
> fsl_elbc_chip_remove(). The right place to do that is in fsl_elbc_nand_remove()
> if elbc_fcm_ctrl->counter is zero.
> 
> Signed-off-by: Liu Shuo <b35362@freescale.com>

Changed the subject to something shorted and pushed to l2-mtd-2.6.git,
thanks.

-- 
Best Regards,
Artem Bityutskiy
