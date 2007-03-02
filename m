Return-Path: <rmcguire@videopresence.com>
Received: from smtpout04-04.prod.mesa1.secureserver.net
	(smtpout04-04.prod.mesa1.secureserver.net [64.202.165.199])
	by ozlabs.org (Postfix) with SMTP id 7B8D9DDF6E
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 09:58:18 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1048.1172865151.21008.linuxppc-embedded@ozlabs.org>
Subject: 8360E - PCI - BRIDGE
Date: Fri, 2 Mar 2007 14:59:58 -0800
Message-ID: <000c01c75d1e$80abe720$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.1048.1172865151.21008.linuxppc-embedded@ozlabs.org>
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I was wondering if anyone had a small suggestion of PCI cards to begin
testing Linux with for debugging a PCI bus / software / setup.

Basically I am looking for a couple of cards that are known to have good
working PPC drivers for PCI, hopefully built-in into the kernel. Preferable
that somebody has first has experience with.

I seem to be having issues with Linux only, and getting my PCI stuff to
work. Still not sure if these are DTV blob issues, or incompatibility with
the PCI-PCI bridge chip I have in the PPC system.

Questions:

1) Can somebody provide the names of just a few cards that have been tested
with these 82xx 83xx PCI busses that have worked in Linux 2.6.xx? I hope to
not be fighting endian issues in the drivers at first.

2) What is available / known about PCI bridge compatibility / enumeration
when it comes to PPC architecture? I know Linux sees the bridge, but are
there mapping compatibility issues introduced if an extra bridge is in
place?

3) Directly related to Question 2, is there any special options have to be
enabled in the Linux 2.6.xx kernel <2.6.20 specifically> to make this
happen? PreP compliance, G5 support, no idea I am just throwing ideas.


Any help appreciated, I was hoping originally that once the PCI was happy
inside U-boot that Linux wouldn't be such a far target.
