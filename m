Message-Id: <200102221857.f1MIvW706290@ashley.ivey.uwo.ca>
Date: Thu, 22 Feb 2001 13:57:33 -0500
Reply-To: khendricks@ivey.uwo.ca
Content-Type: text/plain;
	charset=us-ascii
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0 (Apple Message framework v337)
Subject: Re: do md5sums differ across architectures?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Just to have a bit of fun, how about this (3 different systems)
Each generates a different md5sum but all generate the same cksum!
(and adding -b to md5sum makes no difference)

Darwin khendricksmac 1.2 Darwin Kernel Version 1.2: Wed Aug 30 23:32:53 PDT 2000; root:xnu/xnu-103.obj~1/RELEASE_PPC  Power Macintosh powerpc

[khendricksmac:~] kbhend% md5sum oo619b_src.tar.bz2
9c6a44ad66572c834e282eb1ec665374  oo619b_src.tar.bz2
[khendricksmac:~] kbhend% cksum oo619b_src.tar.bz2
2458761606 56057947 oo619b_src.tar.bz2


SunOS crunch 5.7 Generic_106541-04 sun4u sparc SUNW,Ultra-250

kbhend$ md5sum oo619b_src.tar.bz2
278c21a764126027cba9cb685b7e96cf  oo619b_src.tar.bz2
kbhend$ cksum oo619b_src.tar.bz2
2458761606      56057947        oo619b_src.tar.bz2


Linux localhost 2.2.17pre10-ben2 #3 Sun Aug 13 13:03:45 EDT 2000 ppc unknown

[kbhend@localhost /src2]$ md5sum oo619b_src.tar.bz2
c4a5d7bda6973f6b56e725295d1b3dfb  oo619b_src.tar.bz2
[kbhend@localhost /src2]$ cksum oo619b_src.tar.bz2
2458761606 56057947 oo619b_src.tar.bz2


I guess md5sum is not a very reliable or consistent checksum measure for moving
files between ppc linux, MacOSX, and Solaris 7 Sparc.

Back to the old cksum for me.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
