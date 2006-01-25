Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx011.isp.belgacom.be (outmx011.isp.belgacom.be
	[195.238.5.3])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5E96168A88
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jan 2006 22:15:30 +1100 (EST)
Received: from outmx011.isp.belgacom.be (localhost [127.0.0.1])
	by outmx011.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0PBFK9j025776
	for <linuxppc-embedded@ozlabs.org>; Wed, 25 Jan 2006 12:15:21 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx011.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0PBFDiZ025694
	for <linuxppc-embedded@ozlabs.org>; Wed, 25 Jan 2006 12:15:15 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: [RFC] arch/ppc/boot/simple/embed_boot.c : Merging all keyvals parsing
	code
Date: Wed, 25 Jan 2006 12:15:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200601251215.10816.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

the Embedded Planet boards boot loader pass a string containing key/value 
pairs to the Linux loader code. That string is parsed in 
arch/ppc/simple/embed_boot.c.

The current implementation duplicates the parsing code once for each supported 
board. As I'm adding support for a new EP board (EP8248), I was wondering if 
it would be worth merging all those parsers together. This would reduce the 
source code size, but would be pointless at runtime as only one board support 
code is compiled in the kernel anyway.

Should I submit a patch, or leave the code as it is ?

Laurent Pinchart
