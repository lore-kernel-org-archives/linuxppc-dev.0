Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 41966B717F
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Sep 2010 21:44:01 +1000 (EST)
Received: by ewy2 with SMTP id 2so1181784ewy.15
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Sep 2010 04:44:00 -0700 (PDT)
Date: Fri, 3 Sep 2010 15:43:57 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 2/3][MTD] P4080/nand: Only make elbc nand driver detect
	nand flash partitions
Message-ID: <20100903114357.GC11847@oksana.dev.rtsoft.ru>
References: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
	<1281063096-26598-2-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1281063096-26598-2-git-send-email-tie-fei.zang@freescale.com>
Cc: B25806@freescale.com, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org,
	Scott Wood <scottwood@freescale.com>, akpm@linux-foundation.org,
	B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 06, 2010 at 10:51:35AM +0800, Roy Zang wrote:
[...]
>  
> +static struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl;
> +

Are you sure that you want it as a global var? A bit scary change.

Oh, you probably don't need it, as you can get it from
fsl_lbc_ctrl_dev->nand?

I wonder if Scott saw these patches? Cc'ed.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
