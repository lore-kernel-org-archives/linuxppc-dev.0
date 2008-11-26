Return-Path: <david.goodenough@linkchoose.co.uk>
Received: from apollo.linkchoose.co.uk (ip-217-204-115-127.easynet.co.uk
	[217.204.115.127]) by ozlabs.org (Postfix) with ESMTP id BBC70DDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Nov 2008 09:14:16 +1100 (EST)
Received: from galaxy.linkchoose.co.uk ([10.98.1.127] helo=galaxy.dga.co.uk)
	by apollo.linkchoose.co.uk with esmtp (Exim 4.60)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1L5RzL-0000cn-9S
	for linuxppc-embedded@ozlabs.org; Wed, 26 Nov 2008 21:31:59 +0000
Received: from [10.0.1.66] (helo=stargate.dga.co.uk)
	by galaxy.dga.co.uk with esmtp (Exim 4.69)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1L5Rxm-00046Q-25
	for linuxppc-embedded@ozlabs.org; Wed, 26 Nov 2008 21:30:22 +0000
From: David Goodenough <david.goodenough@linkchoose.co.uk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: JVM on e500 core
Date: Wed, 26 Nov 2008 21:31:34 +0000
References: <5c9cd53b0811261123g457bd680h2d2df68da373da59@mail.gmail.com>
In-Reply-To: <5c9cd53b0811261123g457bd680h2d2df68da373da59@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811262131.35538.david.goodenough@linkchoose.co.uk>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 26 November 2008, mike zheng wrote:
> Hi All,
>
> I am using MPC8568 with e500 core. The cross-compiler I am using from
> Freescale - GCC 3_3-e500, glibc 2.3.2 and binutils 2.15.
>
> Any one know if Java Virtual Machine is supported on the e500 core
> processor? Has e500 support been added to GCJ?

As I understand it, gcj is just a new front end which understands both
the java language and its byte code.  It then uses either the byte code
emitter or whatever other architectural emitters already exist for 
gcc.  So if gcc supports the e500 then so should gcj.  The support 
library is another storym but that is either Java or C so it should work.

But then my understanding may be wrong, and the only real way to 
find out it try it.

David
>
> Thanks for your help,
>
> Mike
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
