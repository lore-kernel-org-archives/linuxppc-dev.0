Message-Id: <5.1.0.14.0.20010917083305.02c55ec0@pop.gmx.de>
Date: Mon, 17 Sep 2001 08:38:23 +0800
To: "qiuqingjun" <qiuqingjun@263.net>,
	<linuxppc-embedded@lists.linuxppc.org>
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: Where can I download a done ramdisk.image ?
In-Reply-To: <003801c13ea8$4e68bf80$0200a8c0@aiwa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 08:08 PM 9/16/2001 +0800, qiuqingjun wrote:

>Hi, all,
>I need a ramdisk.image for initrd, in which I can access the /proc/net,
>and can use ftp,ping or other simple net applications. However, when I
>added some scripts according to the description in
>http://www.linux.org/docs/ldp/howto/Bootdisk-HOWTO/buildroot.html
>I could not get the correct result yet. Where can I download a done
>ramdisk.image? or an instruction about how to build root in embedded
>system in detail.

In ftp://ftp.denx.de/pub/LinuxPPC/usr/src/ you will find
mini-2048kB.ramdisk and simple-ramdisk.
Both don't provide the tools you requested, but it's a good start.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
