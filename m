Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C61BB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Sep 2010 21:25:13 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	o8EBP7is016471
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Sep 2010 13:25:07 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Generating elf kernel ?
Date: Tue, 14 Sep 2010 13:27:19 +0200
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>
	<4C8F49A1.9050008@windriver.com>
In-Reply-To: <4C8F49A1.9050008@windriver.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201009141327.19117.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Which bootloader? Looks you want to run it as XIP.

I have my own downloader which does a few things and then transfers the kernel 
from a flash to the memory and then simply jumps to the 1st address with a 
0x40000() C function call.

But I need to first use Xilinx tools to transfer the kernel from the 
development PC to the memory of my device (and then my own 'one-time-only' 
tool to transfer from mem to flash). And the xilinx program refuses that 
kernel, complaining that it's not an elf file.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
