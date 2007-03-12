Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F32BCDDD01
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 04:00:45 +1100 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l2CH0VFU038708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Mar 2007 18:00:37 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.lan with local (Exim 4.66 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1HQnst-00027p-3q
	for linuxppc-embedded@ozlabs.org; Mon, 12 Mar 2007 18:00:31 +0100
Date: Mon, 12 Mar 2007 18:00:31 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Problem in compiling a kernel module
Message-ID: <20070312170030.GA5613@server.idefix.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Matthias Fechner <idefix@fechner.net>
Reply-To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm not sure if this is the right list, so please correct me.

If have written a kernel module to read a I2C chip (it's very basic
now and I try to understand some thinks first so please forgive some
stupid questions).

I copied it to drivers/i2c/chips and added it into the Makefile with
the following line:
obj-m += max6633.o

If I try now to compile to kernel I got the following error message:
WARNING: drivers/i2c/chips/max6633.o - Section mismatch: reference to
.init.data: from .text after 'cleanup_module' (at offset 0x196)
WARNING: drivers/i2c/chips/max6633.o - Section mismatch: reference to
.init.data: from .text after 'cleanup_module' (at offset 0x1a6)
WARNING: drivers/i2c/chips/max6633.o - Section mismatch: reference to
.init.data: from .text after 'cleanup_module' (at offset 0x1da)
WARNING: drivers/i2c/chips/max6633.o - Section mismatch: reference to
.init.data: from .text after 'cleanup_module' (at offset 0x1e2)

What does that mean or how can debug or solve the problem?

Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
