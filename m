Date: Tue, 18 Sep 2001 10:25:20 +0200
From: Jure Menart <jure@kom.org>
To: qiuqingjun <qiuqingjun@263.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: When does the linuxrc script execute?
Message-ID: <20010918102520.A12303@hannanges.teden-mladih.com>
References: <004801c13eaa$b35d8ea0$0200a8c0@aiwa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <004801c13eaa$b35d8ea0$0200a8c0@aiwa>; from qiuqingjun@263.net on Sun, Sep 16, 2001 at 08:25:17PM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
On Sun, Sep 16, 2001 at 08:25:17PM +0800, qiuqingjun wrote:
> I downloaded the source code of linux-2.2.14 and simple-ramdisk.image.gz from
> ftp://ftp.denx.de/pub/LinuxPPC/usr/src/.
> In ramdisk, there is a file named /linuxrc which includes some shell scripts, but why it is NOT executed when system boot?

could you be more specific - your system can't really boot without /linuxrc,
because shell is called in it.
So you system doesn't boot I guess? If I'm correct, where does it stop?

BTW. linuxrc is executed when kernel preparing namespace, that is after all
initializations, preparing devices... it is in 'init' thread.

--
Ah, kakor pot je nase zivljenje,
temna, zavita,                                             LP, Jure
brez dalj -
V prsi zabodeno hrepenenje,
negativni total.
--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
