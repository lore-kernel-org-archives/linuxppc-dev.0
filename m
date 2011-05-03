Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D9D2B6FC2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 May 2011 15:43:02 +1000 (EST)
Received: by iym7 with SMTP id 7so6378732iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 02 May 2011 22:42:59 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4DBF8FF6.8030100@denx.de>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1300782452-528-1-git-send-email-hs@denx.de>
	<20110502221406.GA15043@ponder.secretlab.ca> <4DBF8FF6.8030100@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 2 May 2011 23:42:39 -0600
Message-ID: <BANLkTimacM29RHExZounuziF+7jARQxdTg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] powerpc, 52xx: add charon board support
To: hs@denx.de
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

On Mon, May 2, 2011 at 11:17 PM, Heiko Schocher <hs@denx.de> wrote:
> Hello Grant,
>
> Grant Likely wrote:
>> On Tue, Mar 22, 2011 at 09:27:26AM +0100, Heiko Schocher wrote:
>>> cc: Wolfram Sang <w.sang@pengutronix.de>
>>> cc: Grant Likely <grant.likely@secretlab.ca>
>>> cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> cc: linux-fbdev@vger.kernel.org
>>> cc: devicetree-discuss@ozlabs.org
>>> cc: Ben Dooks <ben@simtec.co.uk>
>>> cc: Vincent Sanders <vince@simtec.co.uk>
>>> cc: Samuel Ortiz <sameo@linux.intel.com>
>>> cc: linux-kernel@vger.kernel.org
>>> cc: Randy Dunlap <rdunlap@xenotime.net>
>>> cc: Wolfgang Denk <wd@denx.de>
>>> cc: Paul Mundt <lethal@linux-sh.org>
>>>
>>> changes since v5:
>>> - repost complete patchseries, as Paul Mundt suggested
>>> - rebased against current head
>>> - add Acked-by from Samuel Ortiz (MFD parts)
>>> =A0 http://www.spinics.net/lists/linux-fbdev/msg02550.html
>>> =A0 http://linux.derkeiler.com/Mailing-Lists/Kernel/2011-01/msg11798.ht=
ml
>>>
>>> =A0 and Benjamin Herrenschmidt (DTS parts)
>>> =A0 http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-February/088279=
.html
>>> - removed patch
>>> =A0 "powerpc, mpc5200: update mpc5200_defconfig to fit for charon board=
."
>>> =A0 therefore added
>>> =A0 "powerpc, tqm5200: update tqm5200_defconfig to fit for charon board=
."
>>
>> Refresh my memory, why was the mpc5200_defconfig updated dropped?
>
> Because it is a board based on the tqm5200 board port ... no other
> reason.

Please send a patch to also update the mpc5200_defconfig.

g.
