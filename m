Return-Path: <johnny.hacking@gmail.com>
Received: from mail-pz0-f195.google.com (mail-pz0-f195.google.com
	[209.85.222.195]) by ozlabs.org (Postfix) with ESMTP id 28E89B7CC2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jan 2010 14:07:09 +1100 (EST)
Received: by pzk33 with SMTP id 33so581357pzk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 19:07:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2ea1731b1001192357r72d627e2gb36d71f23fd69b2e@mail.gmail.com>
References: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
	<20100119095024.GD16182@darwin>
	<cb9ecdfa1001190213u69469505k9c42142bdc17f750@mail.gmail.com>
	<20100119102026.GF16182@darwin>
	<cb9ecdfa1001190403v433d839dy6ba2bc018024ce15@mail.gmail.com>
	<Pine.LNX.4.64.1001191414090.32263@lnxricardw.se.axis.com>
	<20100119140600.GH16182@darwin>
	<cb9ecdfa1001191832k28961740qa825a8c8d5e631f2@mail.gmail.com>
	<2ea1731b1001192357r72d627e2gb36d71f23fd69b2e@mail.gmail.com>
Date: Fri, 22 Jan 2010 11:07:08 +0800
Message-ID: <cb9ecdfa1001211907u37415485tf3e1d2c443a506f7@mail.gmail.com>
Subject: Re: mount ramdisk rootfs /etc directory to jffs2 filesystem.
From: Johnny Hung <johnny.hacking@gmail.com>
To: Marco Stornelli <marco.stornelli@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ricard Wanderlof <ricard.wanderlof@axis.com>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Matthias Kaehlcke <matthias@kaehlcke.net>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/1/20 Marco Stornelli <marco.stornelli@gmail.com>:
> 2010/1/20 Johnny Hung <johnny.hacking@gmail.com>:
>> 2010/1/19 Matthias Kaehlcke <matthias@kaehlcke.net>:
>>> El Tue, Jan 19, 2010 at 02:17:22PM +0100 Ricard Wanderlof ha dit:
>>>
>> I consider to use ramdisk as rootfs because worry about wrong
>> operation in rootfs (is use jffs2 rootfs) and it will cause system
>> boot up failed.
>> Another query, does the syslogd/klogd log files also store in jffs2
>> rootfs? Write to jffs2 frequently will reduce flash life cycle.
>>
>> BRs, H. Johnny
>>>
>>> --
>

It seems there are a lot of file-systems I have to study :P. The same
question is
how to split my rootfs? Re-mount /etc, /var to another file-sysyem mtd part when
system boot up?

Thank your good advice.
BRs, H. Johnny
> In general a good splitting for rootfs could be: squashfs for rootfs,
> tmpfs for volatile data (/tmp), ubifs (with a flash partition) for
> "strong" permanent data (/etc, ....) and pramfs for "light" permanent
> data (/var/log, .....).
> I think you should "split" your rootfs. Ramdisk is an old approach
> with some drawbacks.
>
> Marco
>
