Return-Path: <sipcop009@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.198])
	by ozlabs.org (Postfix) with ESMTP id 60D1567C59
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 17:02:39 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id l1so190035nzf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 00:02:38 -0700 (PDT)
Message-ID: <5a4792c0050713235574522cfb@mail.gmail.com>
Date: Wed, 13 Jul 2005 23:55:49 -0700
From: SIP COP 009 <sipcop009@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: 8272ADS and Linux 2.6.12
Reply-To: SIP COP 009 <sipcop009@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

We have a MPC8272 Eval Board which came with Linux 2.4 and U-boot. We
wanted to move to 2.6. I downloaded the latest 2.6.12 sources and
compiled the sources for this platform. The kernel is built, have run
the mkimage tool, but the kernel wont boot.  It just hangs after
decompressing the image.

Any ideas  ? Anything different that needs to be done for 2.6 ? Or any
known issues ?

Thanks!
ashutosh
