Return-Path: <markc@mail.com>
Received: from relay04.roc.ny.frontiernet.net (relay04.roc.ny.frontiernet.net
	[66.133.182.167]) by ozlabs.org (Postfix) with ESMTP id CB0A568A02
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jan 2006 02:48:05 +1100 (EST)
Message-ID: <002901c61dd9$7f3eab00$6401a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Jongmin Yoon" <blueguy@blueguy.sarang.net>, <linuxppc-embedded@ozlabs.org>
References: <002d01c61dc8$c90572c0$efb079d2@Thinkpad>
Subject: Re: I'm in troube to port linux on 405ep
Date: Fri, 20 Jan 2006 10:52:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Now, I’m in trouble with porting Linux to AMCC PPC405EP.
I think u-boot was ported successfully, So, I compile linux kernel 2.6.14
with crosstool-0.38
Here is a capture of my terminial

<snip>

setup_arch: enter
setup_arch: bootmem
ocp: exit
arch: exit
@
@
@
@
@
@
@
|^_���^_^_��~L~L~@p^_p^_�^_~L|�~L�^\|^_�|�^_^\p�^_?�^_~@~@|~L^_~L||
^_8~�^_|^_|^_^_^G|^_|^_8|^\~@|^_~L~L��c|~C^_�|�^_�~L�^\|^_�|�|
^_^\?�^_8�^_~@����|~Lp^\~L~@|c�~Lp^_c~@~L|p~@p|~C|�~C|^C�^_^\p��~@|
p~L|����|~C|^_�~@~L|pp��|p^C~L|^_������~L~L~Cp|�^_^\p|cp�~C|^_
|�^C�|^_^G|��~Lp^_|^_|~@|^C~L|~C|||�|^C�^\|^_?~^_8|^Cp|c~@^_^\?pp
^\�^_~@^_^\?�|||~L|^\|�c|~@~L|^_?�^_|��|�|~L|^_�p^C~L|^_���^_^_
��~L~L�p|�^C���p^C~L|^_|p������~L~L�|c��~@|p�p|^_|~L��^_p^_|
|�||^\~L|^_������~L~L�~C~L�^\||~L����|~L|^_|^_�|~@�p~@|�|~L�^\\
�|�|�^_�|^_|^_^_~L~@~@|~C|^_�~@�~L|p��p||^_|~@|�^_8~~L�|p|^C
~L|^_^\?��~@�~C|||^_|^_~L||~C|p|c|���|~C|p~L�~@||��|�p|��p�|�p�||
�^\�������|����^_~@�|��^_�������^_~@�|�^_~@�^_~@��~~

Probably when the kernel (re)configures the terminal it sets it to a
different baud rate

You should send your email in plain text mode, no HTML

Mark Chambers
