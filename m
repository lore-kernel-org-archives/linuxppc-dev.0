Message-ID: <20040224143841.64071.qmail@web15204.mail.bjs.yahoo.com>
Date: Tue, 24 Feb 2004 22:38:41 +0800 (CST)
From: =?gb2312?q?song=20sam?= <samsongshzu@yahoo.com.cn>
Subject: Re: PCI daughter card with USB on a 405GP 
To: Wolfgang Denk <wd@denx.de>, Xavier Miville <xmiville@oerlikon.ca>
Cc: v.sudeep@exgate.tek.com, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040223170937.BB7C5C0655@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Wolfgang Denk wrote:
> We tested a Adaptec AUA-200LP USB 2.0 card in some PPC sytems. It
> worked fine when the devices were already connected at power-on or
> at least when booting Linux, while hot-plug would reliably crash the
> kernel. As far as I understand such behaviour is typical of some of
> the alignment/cache bugs in the Linux kernel's USB code.

I also met this USB problem on LITE_DW board when
using USB keyboard and mouse.Has it solved or not?

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
