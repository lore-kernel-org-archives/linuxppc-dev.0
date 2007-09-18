Return-Path: <tnt@blacksnow.net>
Received: from leia.blacksnow.net (leia.blacksnow.net [213.251.174.139])
	by ozlabs.org (Postfix) with ESMTP id 98264DDDF8
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 15:40:41 +1000 (EST)
Message-ID: <58950.87.65.18.190.1190089793.squirrel@www.opensources.be>
In-Reply-To: <9e4733910709171915neced927yaf014a08ce21aa66@mail.gmail.com>
References: <11899400103383-git-send-email-tnt@246tNt.com>
	<9e4733910709171915neced927yaf014a08ce21aa66@mail.gmail.com>
Date: Tue, 18 Sep 2007 06:29:53 +0200 (CEST)
Subject: Re: [PATCH 0/7] MPC52xx Bestcomm submission for 2.6.24
From: tnt@blacksnow.net
To: "Jon Smirl" <jonsmirl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On 9/16/07, Sylvain Munaut <tnt@246tnt.com> wrote:
>> Hello Paul, Hi everyone,
>>
>> This series of patch is mainly the bestcomm support for
>> the mpc5200. It was posted a while ago and received some
>> comments. Theses are all addressed here (afaik).
>
> Does this series supersede these pacthes out of your older series?

Yes.
Those are the patches I wrote to fix the comments received last time.
They are now merged inside the main patches.

Apparently I forgot to fix some other comments so I'll have to do
that and repost again.


Sylvain

>
> 0010-powerpc-In-rheap.c-move-the-EXPORT_SYMBOL-and-use.patch
> 0011-powerpc-BestComm-move-the-EXPORT_SYMBOL-and-use-th.patch
> 0012-powerpc-BestComm-ATA-task-move-the-EXPORT_SYMBOL-a.patch
> 0013-powerpc-BestComm-FEC-task-move-the-EXPORT_SYMBOL-a.patch
> 0014-powerpc-BestComm-GenBD-task-move-the-EXPORT_SYMBOL.patch
> 0015-powerpc-BestComm-Replace-global-variable-bcom-by-b.patch
> 0016-powerpc-Make-the-BestComm-driver-a-standard-of_plat.patch
> 0017-powerpc-Fix-typo-in-BestComm-ATA-task-support-code.patch
> 0018-powerpc-BestComm-ATA-task-microcode-insert-copyri.patch
> 0019-powerpc-BestComm-FEC-task-microcode-insert-copyri.patch
> 0020-powerpc-BestComm-GenBD-task-microcode-insert-copy.patch
> 0021-powerpc-Fix-errors-in-bcom-bcom_eng-renaming.patch
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>
>
