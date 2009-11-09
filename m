Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id D61F2B7B77
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 11:43:28 +1100 (EST)
Received: by yxe8 with SMTP id 8so3521670yxe.17
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Nov 2009 16:43:26 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1257328160-24955-1-git-send-email-w.sang@pengutronix.de>
References: <fa686aa40910311803m43504167s1ad802aecd2b4344@mail.gmail.com>
	<1257328160-24955-1-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 9 Nov 2009 12:12:31 -0700
Message-ID: <fa686aa40911091112v494643f9y1a65670ade7edb8@mail.gmail.com>
Subject: Re: [PATCH] spi/mpc52xx: replace printk with dev_err
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 4, 2009 at 2:49 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> To easily identify which device has problems.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> =A0drivers/spi/mpc52xx_psc_spi.c | =A0 =A05 ++---
> =A01 files changed, 2 insertions(+), 3 deletions(-)

picked up.  Thanks

g.
