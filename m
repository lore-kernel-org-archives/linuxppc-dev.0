Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F304B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Mar 2011 07:58:33 +1100 (EST)
Received: by iym7 with SMTP id 7so8433656iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Mar 2011 13:58:30 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1300782452-528-1-git-send-email-hs@denx.de>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1300782452-528-1-git-send-email-hs@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 22 Mar 2011 14:58:09 -0600
Message-ID: <AANLkTi=Da06s2WeA0+9fshBV2ME-ADHPBWxZ5iL6rM_T@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] powerpc, 52xx: add charon board support
To: Heiko Schocher <hs@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Samuel Ortiz <sameo@linux.intel.com>, Vincent Sanders <vince@simtec.co.uk>,
	linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 22, 2011 at 2:27 AM, Heiko Schocher <hs@denx.de> wrote:
> cc: Wolfram Sang <w.sang@pengutronix.de>
> cc: Grant Likely <grant.likely@secretlab.ca>
> cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> cc: linux-fbdev@vger.kernel.org
> cc: devicetree-discuss@ozlabs.org
> cc: Ben Dooks <ben@simtec.co.uk>
> cc: Vincent Sanders <vince@simtec.co.uk>
> cc: Samuel Ortiz <sameo@linux.intel.com>
> cc: linux-kernel@vger.kernel.org
> cc: Randy Dunlap <rdunlap@xenotime.net>
> cc: Wolfgang Denk <wd@denx.de>
> cc: Paul Mundt <lethal@linux-sh.org>
>
> changes since v5:
> - repost complete patchseries, as Paul Mundt suggested
> - rebased against current head
> - add Acked-by from Samuel Ortiz (MFD parts)
> =A0http://www.spinics.net/lists/linux-fbdev/msg02550.html
> =A0http://linux.derkeiler.com/Mailing-Lists/Kernel/2011-01/msg11798.html
>
> =A0and Benjamin Herrenschmidt (DTS parts)
> =A0http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-February/088279.ht=
ml
> - removed patch
> =A0"powerpc, mpc5200: update mpc5200_defconfig to fit for charon board."
> =A0therefore added
> =A0"powerpc, tqm5200: update tqm5200_defconfig to fit for charon board."

Why?  As Wolfram mentioned, I'd rather see mpc5200 defconfig used.
Eventually I'd like to remove tqm5200_defconfig

I'll look through the rest of the patches soon.

g.
