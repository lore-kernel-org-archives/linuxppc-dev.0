Return-Path: <joakim.tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 037C12BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 04:57:03 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Date: Fri, 14 Jan 2005 18:56:58 +0100
Message-ID: <JPEALJAFNGDDLOPNDIEEAECFDAAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050114174734.GB28724@smtp.west.cox.net>
Cc: "Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH] Handle I-TLB Error and Miss separately on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > Your patch will fix this. 
> > I havn't seen it go in yet, will you submit the patch to Linus/Marcelo?
> 
> I was hoping Marcelo would pick this up since I thought he was on the
> list.  I'll re-poke him.  For 2.6, the app in question crashes
> differently, prior to hitting this bug, but I do want to get it pushed
> out.  I've just been swamped lately.

Is 2.6 on 8xx stable for you(except for this app)? I was under the impression that
2.6 was a bit flaky due to an unidentified MM bug.

 Jocke
