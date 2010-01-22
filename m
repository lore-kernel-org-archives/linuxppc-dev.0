Return-Path: <marco.stornelli@gmail.com>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by ozlabs.org (Postfix) with ESMTP id 2A173B7CB8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jan 2010 19:14:56 +1100 (EST)
Received: by ey-out-1920.google.com with SMTP id 26so205336eyw.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jan 2010 00:14:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cb9ecdfa1001211907u37415485tf3e1d2c443a506f7@mail.gmail.com>
References: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
	<20100119095024.GD16182@darwin>
	<cb9ecdfa1001190213u69469505k9c42142bdc17f750@mail.gmail.com>
	<20100119102026.GF16182@darwin>
	<cb9ecdfa1001190403v433d839dy6ba2bc018024ce15@mail.gmail.com>
	<Pine.LNX.4.64.1001191414090.32263@lnxricardw.se.axis.com>
	<20100119140600.GH16182@darwin>
	<cb9ecdfa1001191832k28961740qa825a8c8d5e631f2@mail.gmail.com>
	<2ea1731b1001192357r72d627e2gb36d71f23fd69b2e@mail.gmail.com>
	<cb9ecdfa1001211907u37415485tf3e1d2c443a506f7@mail.gmail.com>
Date: Fri, 22 Jan 2010 09:14:54 +0100
Message-ID: <2ea1731b1001220014v59ea7767m6e1a8547d41c6afb@mail.gmail.com>
Subject: Re: mount ramdisk rootfs /etc directory to jffs2 filesystem.
From: Marco Stornelli <marco.stornelli@gmail.com>
To: Johnny Hung <johnny.hacking@gmail.com>
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

2010/1/22 Johnny Hung <johnny.hacking@gmail.com>:
> 2010/1/20 Marco Stornelli <marco.stornelli@gmail.com>:
>> 2010/1/20 Johnny Hung <johnny.hacking@gmail.com>:
>>> 2010/1/19 Matthias Kaehlcke <matthias@kaehlcke.net>:
>>>> El Tue, Jan 19, 2010 at 02:17:22PM +0100 Ricard Wanderlof ha dit:
>>>>
>>> I consider to use ramdisk as rootfs because worry about wrong
>>> operation in rootfs (is use jffs2 rootfs) and it will cause system
>>> boot up failed.
>>> Another query, does the syslogd/klogd log files also store in jffs2
>>> rootfs? Write to jffs2 frequently will reduce flash life cycle.
>>>
>>> BRs, H. Johnny
>>>>
>>>> --
>>
>
> It seems there are a lot of file-systems I have to study :P. The same
> question is
> how to split my rootfs? Re-mount /etc, /var to another file-sysyem mtd part when
> system boot up?
>

Simply, you can mount each mount point with the fstab file and a
script, same approach of every linux distribution, nothing more. Even
in the pc world you can mount your /home on a partition with ext3,
/var in a partition with ext4, and so on. A very simple approach to
setup the system, it is to start with NFS for example with "whole" fs,
copy what you need in the right place, setup the start-up script and
reboot.

Marco
