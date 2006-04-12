Return-Path: <aidan@nicta.com.au>
Received: from mail25.syd.optusnet.com.au (mail25.syd.optusnet.com.au
	[211.29.133.166])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE4C567BBF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 08:11:02 +1000 (EST)
Message-ID: <443D7AF5.6030401@nicta.com.au>
Date: Thu, 13 Apr 2006 08:11:01 +1000
From: Aidan Williams <aidan@nicta.com.au>
MIME-Version: 1.0
To: Vincent Winstead <vwinstead@yahoo.com>
Subject: Re: Xilinx Virtex-2 PRO FPGA ppc 405 on ML310 board
References: <528646bc0604121142l115a4fa4r1d9e6bc532300fb7@mail.gmail.com>	<20060412193338.75924.qmail@web52010.mail.yahoo.com>
	<528646bc0604121252r48d93ac0ubf7d60116815c1b5@mail.gmail.com>
In-Reply-To: <528646bc0604121252r48d93ac0ubf7d60116815c1b5@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> If you use 2.4: You need to use rsync to get the linuxppc-2.4 tree
> because I don't think anyone is maintaining .tar.gz of the rsync
> snapshot.  Email Tom Rini and ask him.  The linuxppc-2.4 tree is
> special because it's one of the trees that actually has the ML300
> patches integrated.  Mainline does not.
> 

For 2.4, I've had good success on two different boards
using the v2pro and virtex4 parts with:

   http://www.itee.uq.edu.au/~pml/uclinux_powerpc/

The kernel tarball there has support for various xilinx
supplied peripheral cores..

The neat thing about this approach is that there is a
uclinux BSP for the EDK that is used to generate an
auto-config.in file which you then drop directly
into the linux kernel tree.

Even though it is about the microblaze rather than
the PPC, a helpful "getting started" document is:
http://www.itee.uq.edu.au/~wu/downloads/uClinux_ready_Microblaze_design.pdf

- aidan
