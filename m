Return-Path: <lists@petig-baender.de>
Received: from e.frontend.um.mediaways.net (e.frontend.um.mediaways.net
	[62.53.231.247]) by ozlabs.org (Postfix) with SMTP id 8ECA02BDB5
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2004 19:03:26 +1100 (EST)
Message-ID: <41AC292C.70301@petig-baender.de>
Date: Tue, 30 Nov 2004 09:02:52 +0100
From: Christof Petig <lists@petig-baender.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Frank Murphy <murphyf+xfree86@f-m.fm>
References: <200411232008.16854.murphyf+xfree86@f-m.fm>	<200411270948.08054.murphyf+xfree86@f-m.fm>	<1101607094.5176.0.camel@gaston>	<200411282114.48141.murphyf+xfree86@f-m.fm>	<1101674379.4653.9.camel@gaston>	<1101721355.31317.209633721@webmail.messagingengine.com>
	<41AB5995.9080009@petig-baender.de>
In-Reply-To: <41AB5995.9080009@petig-baender.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, debian-x@lists.debian.org
Subject: Re: G3 iBook LCD brightness in X under kernel 2.4.25 and 2.6.8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christof Petig schrieb:
> My last experiment with 2.6.9 gave me (IIRC): The console is switched to 
> a text console, some power management transition messages appear, the 
> hard disc parks, the text remains readable ... Pressing a screen gives 
> CD spinup, more messages and the computer switches back to the X console.
> 
> I will retry with Linus latest tree.

I can confirm that everything works well with Linus' 2.6.10-rc2-bk6. So 
consider the problem as solved (writing from said version).

snooze and the brightness keys work well.

    Christof

PS: related (?) config settings

CONFIG_ADB=y
# CONFIG_ADB_CUDA is not set
CONFIG_ADB_PMU=y
CONFIG_PMAC_PBOOK=y
CONFIG_PMAC_APM_EMU=y
CONFIG_PMAC_BACKLIGHT=y
# CONFIG_ADB_MACIO is not set
CONFIG_INPUT_ADBHID=y
CONFIG_MAC_EMUMOUSEBTN=y

# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
# CONFIG_FB_ATY_XL_INIT is not set
# CONFIG_FB_ATY_GX is not set
