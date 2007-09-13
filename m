Return-Path: <jdi@l4x.org>
Received: from rzcomm22.rz.tu-bs.de (rzcomm22.rz.tu-bs.de [134.169.9.68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0AF07DDED8
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 17:05:28 +1000 (EST)
Message-ID: <46E8DF49.7090402@l4x.org>
Date: Thu, 13 Sep 2007 08:57:13 +0200
From: Jan Dittmer <jdi@l4x.org>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Define termios_1 functions for powerpc, s390, avr32 and frv
References: <18152.719.316280.579601@cargo.ozlabs.ibm.com>
In-Reply-To: <18152.719.316280.579601@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Michael Neuling <mikey@neuling.org>, hskinnemoen@atmel.com,
	heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Alan Cox <alan@redhat.com>,
	akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Commit f629307c857c030d5a3dd777fee37c8bb395e171 introduced uses of
> kernel_termios_to_user_termios_1 and user_termios_to_kernel_termios_1
> on all architectures.  However, powerpc, s390, avr32 and frv don't
> currently define those functions since their termios struct didn't
> need to be changed when the arbitrary baud rate stuff was added, and
> thus the kernel won't currently build on those architectures.

alpha, parisc, sh, sparc{64,}, xtensa are still broken with this error...

Jan
