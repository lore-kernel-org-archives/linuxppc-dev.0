Return-Path: <joakim.tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64FCD67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 22:20:52 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>,
	<gautran@mrv.com>
Date: Tue, 22 Feb 2005 12:20:44 +0100
Message-ID: <JPEALJAFNGDDLOPNDIEEIECNDBAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Linux 2.6.x on 8xx status
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

dcbz(and a few other cache instr.) is buggy on 8xx CPU:s.
See http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/000867.html
for a litte more input or google.

This bug will cuase random craches or "hangs" if not used with care.
There is an old patch floating around for 2.4 that will workaround the bug by
doing instr. decoding in the TLB Error handler.

 Jocke
