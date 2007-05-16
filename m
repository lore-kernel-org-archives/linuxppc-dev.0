Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 621CCDDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 May 2007 04:03:17 +1000 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l4GI30ml015421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 May 2007 20:03:06 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.lan with local (Exim 4.67 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1HoNq0-00067C-L7
	for linuxppc-embedded@ozlabs.org; Wed, 16 May 2007 20:03:00 +0200
Date: Wed, 16 May 2007 20:03:00 +0200
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200B memory performance
Message-ID: <20070516180259.GA23085@server.idefix.lan>
References: <DD39B5C3F4963040ADC9768BE7E430CB01EB1FEF@is-hdq-exchange.marel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01EB1FEF@is-hdq-exchange.marel.net>
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

Hello Daniel,

* Daniel Schnell <daniel.schnell@marel.com> [15-05-07 11:22]:
> I get the following values on my board:

my result is:
Test (10000) memcpy of sizes (1024) ....
10000 memcpy. Time per memcpy: 1814 [nsec] (564 MB/sec)
 finished.
Test (10000) memcpy of sizes (2048) ....
10000 memcpy. Time per memcpy: 3433 [nsec] (596 MB/sec)
 finished.
Test (10000) memcpy of sizes (4096) ....
10000 memcpy. Time per memcpy: 6687 [nsec] (612 MB/sec)
 finished.
Test (10000) memcpy of sizes (8192) ....
10000 memcpy. Time per memcpy: 21454 [nsec] (381 MB/sec)
 finished.
Test (10000) memcpy of sizes (16384) ....
10000 memcpy. Time per memcpy: 205551 [nsec] (79 MB/sec)
 finished.
Test (1000) memcpy of sizes (32768) ....
1000 memcpy. Time per memcpy: 379875 [nsec] (86 MB/sec)
 finished.
Test (1000) memcpy of sizes (51200) ....
1000 memcpy. Time per memcpy: 588792 [nsec] (86 MB/sec)
 finished.
Test (1000) memcpy of sizes (102400) ....
1000 memcpy. Time per memcpy: 1126511 [nsec] (90 MB/sec)
 finished.
Test (100) memcpy of sizes (1048576) ....
100 memcpy. Time per memcpy: 11307890 [nsec] (92 MB/sec)
 finished.
Test (10) memcpy of sizes (10485760) ....
10 memcpy. Time per memcpy: 120783600 [nsec] (86 MB/sec)
 finished.
Test (5) memcpy of sizes (52428800) ....
5 memcpy. Time per memcpy: 673867800 [nsec] (77 MB/sec)
 finished.
	   


Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
