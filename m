Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 0ACB2679FD
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Aug 2006 17:40:18 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1G9zig-0006HG-RA
	for linuxppc-embedded@ozlabs.org; Mon, 07 Aug 2006 09:40:14 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: XUPV2P, Kernel 2.6.17 boot problem
References: <20060801100220.26176938@bob.dt.e-technik.uni-dortmund.de>
	<44D1021C.5080602@dlasys.net> <87irl8zjl7.fsf@sleipner.barco.com>
	<44D36940.7050908@dlasys.net>
Date: Mon, 07 Aug 2006 09:40:14 +0200
In-Reply-To: <44D36940.7050908@dlasys.net> (David H. Lynch, Jr.'s message of
	"Fri, 4 Aug 2006 17:35:28 +0200")
Message-ID: <87lkq1uh7l.fsf@sleipner.barco.com>
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

>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:

Hi,

David>     Have you tried 2.6.18.x to see if your stuff works with it
David> ?

Yes, 2.6.18-rc3 + my zlib fix
(http://thread.gmane.org/gmane.linux.kernel/428436) or -rc4 once it
hits kernel.org works fine on my v2p-based board.

-- 
Bye, Peter Korsgaard
