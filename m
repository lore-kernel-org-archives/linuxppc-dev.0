Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx024.isp.belgacom.be (outmx024.isp.belgacom.be
	[195.238.4.128])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1A39689D9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jan 2006 19:47:48 +1100 (EST)
Received: from outmx024.isp.belgacom.be (localhost [127.0.0.1])
	by outmx024.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0V8lfD5007624
	for <linuxppc-embedded@ozlabs.org>; Tue, 31 Jan 2006 09:47:42 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [RFC] arch/ppc/boot/simple/embed_boot.c : Merging all keyvals
	parsing code
Date: Tue, 31 Jan 2006 09:47:32 +0100
References: <200601251215.10816.laurent.pinchart@tbox.biz>
	<200601251702.20332.laurent.pinchart@tbox.biz>
	<20060130172851.GF22672@smtp.west.cox.net>
In-Reply-To: <20060130172851.GF22672@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601310947.32463.laurent.pinchart@tbox.biz>
Cc: Dan Malek <dan@embeddedalley.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> No, that's good.  If you can cleanly merge the existing parsing code, by
> all means please do so.  Thanks.

Ok I will. On which kernel tree should I base my patches on ?

Laurent Pinchart
