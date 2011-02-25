Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66226B70E1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Feb 2011 00:28:03 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p1PD1XxB005247
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Feb 2011 14:01:33 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Resources used by driver ?
Date: Fri, 25 Feb 2011 14:01:33 +0100
References: <201102101108.47647.dargaud@lpsc.in2p3.fr>
	<AANLkTin9zsXJX0QrJ2cAZJjAdbGYnQ-S4QCdpzEbrUF_@mail.gmail.com>
In-Reply-To: <AANLkTin9zsXJX0QrJ2cAZJjAdbGYnQ-S4QCdpzEbrUF_@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201102251401.33063.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 16 February 2011 08:01:10 Srivatsan S wrote:
> You can use oprofile to profile the functions of your module. Follow the
> link.
> http://oprofile.sourceforge.net/ <http://oprofile.sourceforge.net/news/>

OK, after some wrestling, I got oprofile installed in my OS (buildroot 2011.02-
rc1) and my kernel (xilinx patches 2.6.35+).

When I start oprofile, I get the following:
# opcontrol --vmlinux=/vmlinux
The specified file /vmlinux does not seem to be valid
Make sure you are using the non-compressed image file (e.g. vmlinux not 
vmlinuz)

# file /vmlinux
/vmlinux: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV), 
statically linked, with unknown capability 0x41000000 = 0x11676e75, with 
unknown capability 0x10000 = 0x90402, not stripped

I used the vmlinux generated found in ../linus-2.6-xlnx/vmlinux
What's wrong with it ?
-- 
Guillaume Dargaud
http://www.gdargaud.net/
