Subject: Re: sbin/init problem
From: David Woodhouse <dwmw2@infradead.org>
To: bharat <bharat@coraltele.com>
Cc: PPC_LINUX <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1810905.1088601425250.JavaMail.administrator@RnDserver>
References: <1810905.1088601425250.JavaMail.administrator@RnDserver>
Content-Type: text/plain
Message-Id: <1088694325.14216.3033.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 01 Jul 2004 16:05:25 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-06-30 at 18:47 +0530, bharat wrote:
> dev/console
> Warning: unable to open an initial console.

>  it is responding to ping but not executing further
> and not showing any shell prompt

How would it show you a shell prompt? Through the console it failed to
open? Make sure there's a /dev/console with major 5, minor 1. What is
your console device? A serial port? What type?

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
