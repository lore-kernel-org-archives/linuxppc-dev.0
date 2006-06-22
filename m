Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx004.isp.belgacom.be (outmx004.isp.belgacom.be
	[195.238.4.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B4B467A65
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Jun 2006 01:33:29 +1000 (EST)
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
	by outmx004.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k5MFXNHI026841
	for <linuxppc-embedded@ozlabs.org>; Thu, 22 Jun 2006 17:33:23 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: entry point of kernel in RAM at 0x0c--linux tree file name
Date: Thu, 22 Jun 2006 17:35:15 +0200
References: <edd12c050606220146i57282781o2052679c8f6108ef@mail.gmail.com>
In-Reply-To: <edd12c050606220146i57282781o2052679c8f6108ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200606221735.15761.laurent.pinchart@tbox.biz>
Cc: Arun Kumar <arunkat@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Arun,

> I would like to kow what is the entry point to kernel at 0x000 after
> decompressing and passing control to 0x0c .
> My kernel crashes somewhere after uncomressing and jumping to 0x0c .
>
> If any one can help the .c /.S file that contains the source of kernel
> startup code in RAM at 0x0/0x0c .

The entry point is in arch/ppc/kernel/head.S. Symbols _start and __start are 
located at 0x00000000 and 0x0000000c respectively.

Best regards,

Laurent Pinchart
