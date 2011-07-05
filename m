Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59EEBB6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 09:01:47 +1000 (EST)
Date: Tue, 5 Jul 2011 18:01:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Matthew L. Creech" <mlcreech@gmail.com>
Subject: Re: [PATCH v2] mtd: eLBC NAND: remove elbc_fcm_ctrl->oob_poi
Message-ID: <20110705180138.469f34d1@schlenkerla.am.freescale.net>
In-Reply-To: <1309905302-1990-1-git-send-email-mlcreech@gmail.com>
References: <20110705151525.438e87dc@schlenkerla.am.freescale.net>
	<1309905302-1990-1-git-send-email-mlcreech@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
	rick22@wi.rr.com, mhench@elutions.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 5 Jul 2011 18:35:02 -0400
"Matthew L. Creech" <mlcreech@gmail.com> wrote:

> From: Mike Hench <mhench@elutions.com>
> 
> The eLBC NAND driver currently follows up each program/write operation with a
> read-back of the page, in order to [ostensibly] fill in ECC data for the
> caller. However, the page address used for this read is always -1, so the read
> will never work correctly.  Remove this useless (and potentially problematic)
> block of code.
> 
> v2: elbc_fcm_ctrl->oob_poi is removed entirely, since this code block was the
> only place it was actually used.

Just noticed, full_page can come out as well.

Otherwise, ACK

-Scott
