Return-Path: <Leonid@a-k-a.net>
Received: from mis011-2.exch011.intermedia.net
	(mis011-2.exch011.intermedia.net [64.78.21.129])
	by ozlabs.org (Postfix) with ESMTP id 8C2ACDDEC5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 02:11:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: zImage.elf loads but does not start
Date: Mon, 23 Apr 2007 09:11:01 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C0159BAAE@ehost011-3.exch011.intermedia.net>
In-Reply-To: <10142161.post@talk.nabble.com>
References: <10079346.post@talk.nabble.com> <10142161.post@talk.nabble.com>
From: "Leonid" <Leonid@a-k-a.net>
To: "Mirek23" <miroslaw.dach@psi.ch>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday, April 23, 2007 8:12 AM Mirek wrote:

> ... Right now I was
> able to come to the point when the kernel was uncompressed but it did
not
> start:

You cannot tell that. Most likely you still have problem with serial
(though one cannot be sure). Please try this: go to
drivers/serial/8250.c, find the line=20

#ifdef SERIAL_PORT_DFNS

and add=20

#undef SERIAL_PORT_DFNS

right before it. See what happens.

Leonid.
