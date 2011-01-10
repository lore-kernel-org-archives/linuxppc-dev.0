Return-Path: <rbeims@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) by ozlabs.org (Postfix) with ESMTP id C6A0DB713B
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 03:35:40 +1100 (EST)
Received: by fxm11 with SMTP id 11so21637294fxm.15
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jan 2011 08:35:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OFBA8894F8.FF5AA75D-ONC1257812.00773DA9-C1257812.00776196@transmode.se>
References: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>
	<4D24B725.2020300@evidence.eu.com>
	<20110105174256.29fd378a@udp111988uds.am.freescale.net>
	<4D25BB08.7000001@evidence.eu.com>
	<OFB0350E05.07B070EF-ONC1257810.005CAF17-C1257810.005CAF19@transmode.se>
	<AANLkTinbdEc2kTVHZp3b31V6sFSqOfquUidb5BZYdgEX@mail.gmail.com>
	<OFBA8894F8.FF5AA75D-ONC1257812.00773DA9-C1257812.00776196@transmode.se>
Date: Mon, 10 Jan 2011 14:35:38 -0200
Message-ID: <AANLkTi=cAswFh1cFCU=nomd6yg5Ux9jK0x9h9s7f2571@mail.gmail.com>
Subject: Re: mpc880 linux-2.6.32 slow running processes
From: Rafael Beims <rbeims@gmail.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1
Cc: michael@evidence.eu.com, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	scottwood <scottwood@freescale.com>, RFeany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Once you have tested it and it works, please send a patch to remove the 8xx workaround.
> Make sure Scott is cc:ed
>
>

I tested linux-2.6.33 on my ppc880 board today, and even without the
slowdown.patch applied, the board runs processes with good
performance.
It really seems that the problem is solved from linux-2.6.33 on.

I'm not sure what you mean by sending a patch to remove the
workaround. The only thing that I did in the 2.6.32 version was to
apply the slowdown.patch attached in the message from Michael.

Could you clarify please?

Thanks for all the help so far,
Rafael
