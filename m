Return-Path: <jonmasters@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.199])
	by ozlabs.org (Postfix) with ESMTP id BB08C2BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Oct 2004 08:28:28 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so4830858rnk
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 04 Oct 2004 15:28:26 -0700 (PDT)
Message-ID: <35fb2e5904100415285979b343@mail.gmail.com>
Date: Mon, 4 Oct 2004 23:28:26 +0100
From: Jon Masters <jonmasters@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: smc91111
Reply-To: jonathan@jonmasters.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I've got a hacked version of the smc91111 driver from an old arm tree
that I'm happily using on my board at work - I'll post patches for it
in due course as we use a custom 16bit bus that physically looks and
acts like ISA (but really is cunningly slightly different in timing
and spec as it's a soft core implemented bridge bodged together to
work on a dev board. mmmmmm.).

Today I had to add some ethtool support to the driver to support using
howl (anybody else use that to do Zero Conf?) and was debating fixing
up http://criticalmass.sourceforge.net/kernel/smc91x/ to work with odd
bus types like ours (it's a lot of work and testing compared with a
quick hack to get this done on time so this question is more
hyperthetical when I'm done with the immediate problem).

Who is using the SMC91111 family of MACs and if so which driver do you use?

Jon.
