Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 431D8B7D7A
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 18:04:24 +1100 (EST)
Received: by gyg13 with SMTP id 13so124320gyg.15
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 23:04:23 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1267307902-31939-1-git-send-email-agust@denx.de>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
	<1267307902-31939-1-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 28 Feb 2010 00:04:03 -0700
Message-ID: <fa686aa41002272304v8576e7bnf10759b784acd3c5@mail.gmail.com>
Subject: Re: [PATCH 0/3] Rework MPC5121 DIU support (for 2.6.34)
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, jrigby@gmail.com,
	linuxppc-dev@ozlabs.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anatolij,

On Sat, Feb 27, 2010 at 2:58 PM, Anatolij Gustschin <agust@denx.de> wrote:
> This patch series rework DIU support patch submitted
> previously with the patch series for updating MPC5121
> support in mainline. It doesn't add new panel timing data
> to the framebuffer driver anymore. Instead we now allow
> encoding this data in the device tree. First two patches
> add this support.

Thanks for this work.  I've made specific comments on the individual
patches.  There are some details to be worked out, but I think it is
moving in the right direction.

> It is intended for inclusion in 2.6.34, since without
> DIU support patch framebuffer doesn't work on mpc5121.

It's actually late for 2.6.34.  Unless it is a bug fix, I stop picking
up new patches somewhere in the -rc7 or -rc8 timerframe, and I am
definitely in bug-fix-only mode once the merge window has opened.  I
do this to ensure all patches receive a decent amount of linux-next
exposure before I ask Linus to pull them.

I'll being picking up new patches for 2.6.35 into my -next branch
after 2.6.34-rc1 is released.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
