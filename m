Return-Path: <marco.stornelli@gmail.com>
Received: from mail-ew0-f209.google.com (mail-ew0-f209.google.com
	[209.85.219.209]) by ozlabs.org (Postfix) with ESMTP id 0D47FB7C98
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jan 2010 22:54:19 +1100 (EST)
Received: by ewy1 with SMTP id 1so2956138ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jan 2010 03:54:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100120102145.GV16182@darwin>
References: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
	<20100119095024.GD16182@darwin>
	<cb9ecdfa1001190213u69469505k9c42142bdc17f750@mail.gmail.com>
	<20100119102026.GF16182@darwin>
	<cb9ecdfa1001190403v433d839dy6ba2bc018024ce15@mail.gmail.com>
	<Pine.LNX.4.64.1001191414090.32263@lnxricardw.se.axis.com>
	<20100119140600.GH16182@darwin>
	<cb9ecdfa1001191832k28961740qa825a8c8d5e631f2@mail.gmail.com>
	<2ea1731b1001192357r72d627e2gb36d71f23fd69b2e@mail.gmail.com>
	<20100120102145.GV16182@darwin>
Date: Wed, 20 Jan 2010 12:54:16 +0100
Message-ID: <2ea1731b1001200354t5ed29458h6fc98c49c1a555d5@mail.gmail.com>
Subject: Re: mount ramdisk rootfs /etc directory to jffs2 filesystem.
From: Marco Stornelli <marco.stornelli@gmail.com>
To: Matthias Kaehlcke <matthias@kaehlcke.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ricard Wanderlof <ricard.wanderlof@axis.com>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
	kernelnewbies <kernelnewbies@nl.linux.org>,
	Johnny Hung <johnny.hacking@gmail.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/1/20 Matthias Kaehlcke <matthias@kaehlcke.net>:
> El Wed, Jan 20, 2010 at 08:57:44AM +0100 Marco Stornelli ha dit:
>
>> 2010/1/20 Johnny Hung <johnny.hacking@gmail.com>:
>> > 2010/1/19 Matthias Kaehlcke <matthias@kaehlcke.net>:
>> >> El Tue, Jan 19, 2010 at 02:17:22PM +0100 Ricard Wanderlof ha dit:
>> >>
>> > I consider to use ramdisk as rootfs because worry about wrong
>> > operation in rootfs (is use jffs2 rootfs) and it will cause system
>> > boot up failed.
>> > Another query, does the syslogd/klogd log files also store in jffs2
>> > rootfs? Write to jffs2 frequently will reduce flash life cycle.
>> >
>> > BRs, H. Johnny
>> >>
>> >> --
>>
>> In general a good splitting for rootfs could be: squashfs for rootfs,
>> tmpfs for volatile data (/tmp), ubifs (with a flash partition) for
>> "strong" permanent data (/etc, ....) and pramfs for "light" permanent
>> data (/var/log, .....).
>
> if ubifs is a good choice depends on the size of the partition, iirc
> it has a significant overhead for very small partitions.
>
> once using ubi it could be interesting to set up the read-only rootfs
> partition upon ubi in order to spread the wear out over a maximum of blocks.
>

I don't know the size constraints of Johnny, so it can be useful to use jffs2.

Marco
