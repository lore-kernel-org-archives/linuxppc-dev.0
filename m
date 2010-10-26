Return-Path: <shawnxjin@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id BA259B70AA
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Oct 2010 12:01:00 +1100 (EST)
Received: by eyf18 with SMTP id 18so2765488eyf.15
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Oct 2010 18:00:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CC53E18.3050204@windriver.com>
References: <AANLkTikNZ+LD-FZ_vK-R3Rfu7RzRSAL_zT4xbWgYL=8R@mail.gmail.com>
	<4CBC080A.7030005@windriver.com>
	<20101018114214.2e72a616@udp111988uds.am.freescale.net>
	<4CBCFC5D.3010403@windriver.com>
	<AANLkTinN-xOecVynPYxmLoT9HJKFs0iPo3pLXF05Tudv@mail.gmail.com>
	<AANLkTimW1_Hc3kQ2Wbn6zDMUSJvRCxn0XdGw4wB-mm0D@mail.gmail.com>
	<4CC53E18.3050204@windriver.com>
Date: Mon, 25 Oct 2010 18:00:57 -0700
Message-ID: <AANLkTi=yKy=XaTkK9nooP0VZs9rhEF-bWeyD+NL-tqeE@mail.gmail.com>
Subject: Re: CONFIG_FEC is not good for mpc8xx ethernet?
From: Shawn Jin <shawnxjin@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Sorry for this delay response since I'm a bit busying recently:)

No. Don't feel sorry about it. You're not obligated to answer any
questions here. I believe it is the free and willing to help spirit
that drive the open source community (linux particularly) to be such a
success. We all benefit from and contribute to this. :)

> If you're sure that work well at the first time it may be issued from PIN. Are
> the PINs used to MDIO bus multiplexed? Maybe you miss something to re-configure
> PIN with the appropriate mode, OUT direction and some GPIO REGs to bind your PHY
> PINs. I means maybe other drivers also use same PINs and re-configure them, so
> they don't work properly as the first time. So you can try adding some codes to
> re-initial PINs as PHY expect on here to check this again.

After the PIN assignment issue, the cause was simply an unnecessary
reset in fs_init_phy() that was added in the beginning. And I forgot
it. :-P

Tiejun, Scott, many thanks to your kind help.

-Shawn.
