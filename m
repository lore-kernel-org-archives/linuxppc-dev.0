Return-Path: <m@bues.ch>
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E239B6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 24 Jul 2011 06:57:31 +1000 (EST)
Received: by bues.ch with esmtpsa (Exim 4.69) (envelope-from <m@bues.ch>)
	id 1Qkigk-0007Sj-Gf
	for linuxppc-dev@lists.ozlabs.org; Sat, 23 Jul 2011 22:20:42 +0200
Date: Sat, 23 Jul 2011 22:20:34 +0200
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: linuxppc-dev@lists.ozlabs.org
Subject: Linux 3.0 boot failure on the Powerbook G4
Message-ID: <20110723222034.6757604b@maggie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linux 3.0 fails to boot _very_ early on my Powerbook G4. See the
yaboot/OF screenshot:
http://bues.ch/misc/linux-3.0-pbook.jpg

Linux 2.6.39.2 boots fine.
Does somebody have an idea?

The config can be found here:
http://bues.ch/misc/linux-3.0-ppc-config
It's mostly equivalent to the working 2.6.39 config. I enabled
early OF console, but that didn't help to show better error messages.

The machine is a:

cpu             : 7447A, altivec supported
clock           : 1499.999000MHz
revision        : 1.2 (pvr 8003 0102)
platform        : PowerMac
motherboard     : PowerBook5,6 MacRISC3 Power Macintosh 
detected as     : 287 (PowerBook G4 15")
pmac-generation : NewWorld

-- 
Greetings, Michael.
