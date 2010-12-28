Return-Path: <jjdanimoth@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 99700B6F2B
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Dec 2010 03:40:06 +1100 (EST)
Received: by gyf2 with SMTP id 2so6475463gyf.15
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Dec 2010 08:40:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1293550353.19556.224.camel@thor.local>
References: <AANLkTiksBGDR=vJLArgShP8U_NWZ2OWXc65wiXRLv4kr@mail.gmail.com>
	<1293550353.19556.224.camel@thor.local>
From: jjDaNiMoTh <jjdanimoth@gmail.com>
Date: Tue, 28 Dec 2010 17:39:43 +0100
Message-ID: <AANLkTinBQAMvmmNP5S_=++UOQDoTe-1efD39VF0PO5kB@mail.gmail.com>
Subject: Re: PMU_IOC_SLEEP failed
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/12/28 Michel D=C3=A4nzer <michel@daenzer.net>:
[cut]
> What exactly does "can't switch over VT" mean?
After X is running, I can't switch over ctrl + alt + f{1,2,3,4,5,6}
consoles ( the screen flicker, then blank ). If I switch to f7, where
X live, all return to normal and I can see normal X window.
This doesn't happend with X active.

> Sleep requires radeonfb, is that enabled?

Of course, but I think there is something wrong:

(dmesg..)
[...]
radeonfb_pci_register BEGIN
radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0xb8000000-0xbfffffff pref=
]
radeonfb (0000:00:10.0): cannot request region 0.
radeonfb: probe of 0000:00:10.0 failed with error -16
