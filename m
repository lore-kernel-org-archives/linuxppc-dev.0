Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CBD27B6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 May 2011 08:14:11 +1000 (EST)
Received: by pzk26 with SMTP id 26so3785785pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 02 May 2011 15:14:09 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Mon, 2 May 2011 16:14:06 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v6 0/6] powerpc, 52xx: add charon board support
Message-ID: <20110502221406.GA15043@ponder.secretlab.ca>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1300782452-528-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300782452-528-1-git-send-email-hs@denx.de>
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

On Tue, Mar 22, 2011 at 09:27:26AM +0100, Heiko Schocher wrote:
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
>   http://www.spinics.net/lists/linux-fbdev/msg02550.html
>   http://linux.derkeiler.com/Mailing-Lists/Kernel/2011-01/msg11798.html
> 
>   and Benjamin Herrenschmidt (DTS parts)
>   http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-February/088279.html
> - removed patch 
>   "powerpc, mpc5200: update mpc5200_defconfig to fit for charon board."
>   therefore added
>   "powerpc, tqm5200: update tqm5200_defconfig to fit for charon board."

Refresh my memory, why was the mpc5200_defconfig updated dropped?

g.
