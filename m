To: "qiuqingjun" <qiuqingjun@263.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: When does the linuxrc script execute? 
In-Reply-To: Your message of "Sun, 16 Sep 2001 20:25:17 +0800."
             <004801c13eaa$b35d8ea0$0200a8c0@aiwa>
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 20 Sep 2001 09:23:46 +0200
From: Wolfgang Denk <wd@denx.de>
Message-Id: <20010920072351.D925E1009D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I downloaded the source code of linux-2.2.14 and simple-ramdisk.image.gz from
> ftp://ftp.denx.de/pub/LinuxPPC/usr/src/.
> In ramdisk, there is a file named /linuxrc which includes some shell scripts, but why it is NOT executed when system boot?

Check the conditions WHEN a /linuxrc file gets executed, and compare with
your kernel configuration and start procedure. There will be some difference.

Wolfgang Denk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
