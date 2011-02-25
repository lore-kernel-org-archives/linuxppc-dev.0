Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26A6CB70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Feb 2011 01:18:09 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p1PEI5Fd008037
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Feb 2011 15:18:05 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Resources used by driver ?
Date: Fri, 25 Feb 2011 15:18:04 +0100
References: <201102101108.47647.dargaud@lpsc.in2p3.fr>
	<AANLkTin9zsXJX0QrJ2cAZJjAdbGYnQ-S4QCdpzEbrUF_@mail.gmail.com>
	<201102251401.33063.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201102251401.33063.dargaud@lpsc.in2p3.fr>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201102251518.04554.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> When I start oprofile, I get the following:
> # opcontrol --vmlinux=/vmlinux
> The specified file /vmlinux does not seem to be valid
> Make sure you are using the non-compressed image file (e.g. vmlinux not
> vmlinuz)

Sorry, I had an incomplete install of objdump/binutils on my target. I'm now 
trying to understand how to use oprofile.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
