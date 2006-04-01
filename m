Return-Path: <johnsson.douglas@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.207])
	by ozlabs.org (Postfix) with ESMTP id 71E66679E7
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  2 Apr 2006 02:33:16 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id o1so1110273nzf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 01 Apr 2006 07:33:14 -0800 (PST)
Message-ID: <f5e863ae0604010733i7f86a644q1a785432589215ed@mail.gmail.com>
Date: Sat, 1 Apr 2006 17:33:12 +0200
From: "Douglas Johnsson" <johnsson.douglas@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Can't get serial SMC1 and SMC2 working together
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi.
I'm using a TQM823L board, ELDK and Linux 2.4.25 (from denx). My
problem is that i can't use both SMC1 and SMC2 at the same time when I
disable the console
(console=3Dnull).

I use pppd and a gprs on ttyS1 and this is working fine (I use another
computer pinging the modem). However, the instant i open ttyS0 ("echo
test > /dev/ttyS0"),
ttyS1 is affected and the modem goes down (ping timeout).
The behaviour is consistent over other scenarios as well: I can access
both ttyS0 and ttyS1, but not simultaneously.
This is strange since ttyS0 and S1 seems to work together nice when I use
ttyS0 for console.

Can anyone help me solve this problem? I get the feeling i'm missing someth=
ing
trivial here.

Regards,
Doug
