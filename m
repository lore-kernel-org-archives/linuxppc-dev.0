Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id C866867B59
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Sep 2006 17:49:01 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1GPaLi-0001tc-6Y
	for linuxppc-embedded@ozlabs.org; Tue, 19 Sep 2006 09:48:58 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
References: <mailman.241.1158193867.2423.linuxppc-embedded@ozlabs.org>
	<002501c6d79e$cca7ee40$800101df@monstertop>
	<528646bc0609131852s41a8bc4ev44b84d68f51b1d2d@mail.gmail.com>
	<45093A94.2080407@dlasys.net>
	<200609141353.k8EDrkPN065101@penguin.ncube.com>
	<528646bc0609140734j2f7b008fy815f221677c5ac74@mail.gmail.com>
Date: Tue, 19 Sep 2006 09:48:58 +0200
In-Reply-To: <528646bc0609140734j2f7b008fy815f221677c5ac74@mail.gmail.com>
	(Grant Likely's message of "Thu, 14 Sep 2006 16:34:22 +0200")
Message-ID: <87hcz4z47p.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "GL" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

GL> So what direction do we (as the community) want to go for
GL> supporting Xilinx IP in the Linux kernel?

GL> IIRC, Xilinx intends to get drivers submitted into mainline.
GL> (Based on their cross-platform driver support code).  It is
GL> unknown which and how many drivers for different IP versions will
GL> be submitted.

Yes, that's also what I hear from the Xilinx guys - But action speaks
louder than words. It's not like the V2P is new technology anymore.

GL> However, the xilinx driver code is verbose and does not match well
GL> with the rest of the Linux code base.

Yeah, the Xilinx stuff/flow definately doesn't fit the kernel.

GL> If we reject the Xilinx driver code, then we either have to do
GL> without Xilinx support in mainline, or we need to write new
GL> drivers that address the above issues (support multiple IP
GL> versions, etc).  The Xilinx support in mainline right now does not
GL> use any Xilinx code.  (Xilinx PIC and UART).

I think the best option is to simply forget about the Xilinx code,
see the FPGAs as any other PPC system and write normal device drivers
for it. Your platform bus stuff and my (to-be-mainlined) uartlite
driver is a first step in this direction..

-- 
Bye, Peter Korsgaard
