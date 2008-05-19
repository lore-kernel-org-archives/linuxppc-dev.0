Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6677FDDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 May 2008 02:58:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Instruction OCM
Date: Mon, 19 May 2008 09:58:44 -0700
In-reply-to: <012401c8b9c3$74b947c0$5e2bd740$@com>
References: <012401c8b9c3$74b947c0$5e2bd740$@com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "mojtaba" <kernelppc@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080519165845.4430019C0055@mail16-wa4.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The traps are down there in low memory.  trap 700 is probably the one
that deals with MMU exceptions.  My guess is your OCM region is
overlapping with the DDR memory containing that code.

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of mojtaba
> Sent: Monday, May 19, 2008 8:17 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Instruction OCM
> =

> Dear all,
> =

> I cannot run Linux when I have an instruction OCM in my design but,
without instruction OCM
> everything is fine. I tried to do some debugging. It seems that the
Linux memory management unit has
> a problem with that.  After entering the MMU initialization phase, it
suddenly jumps to address
> 0x00000700 it get stuck there. Is there anybody who have tried a
design with instruction OCM? Do I
> need to do special configuration for the Linux kernel?
> =

> Regards,
> =

> Mojtaba


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
