Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 34F03DDE37
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jun 2007 01:02:07 +1000 (EST)
Message-ID: <46700882.9040402@ru.mvista.com>
Date: Wed, 13 Jun 2007 19:08:50 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: silicom <silicom@163.com>
Subject: Re: Request for framebuffer full patch
References: <2073728.680191181708438505.JavaMail.coremail@bj163app51.163.com>
In-Reply-To: <2073728.680191181708438505.JavaMail.coremail@bj163app51.163.com>
Content-Type: text/plain; charset=x-gbk; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

silicom wrote:
>  
> Hi,
> can anybody send me the full patch for framebuffer driver?

The driver itself is in the mainline:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=147394c8ece44be85d692cc92cc0d047e4d8fb69

The code to register the framebuffer device on the platform bus for ML403 and ML300 boards is here:
http://source.mvista.com/git/gitweb.cgi?p=linux-xilinx-26.git;a=commitdiff;h=32b0133b72f9f03381d6db69745aac4bb1d589b2
http://source.mvista.com/git/gitweb.cgi?p=linux-xilinx-26.git;a=shortlog;h=devel

Thanksd,
Andrei

> thanks,
> sherbin
