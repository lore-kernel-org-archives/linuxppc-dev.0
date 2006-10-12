Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 3947D67BEE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 20:34:42 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1GXxte-0004OW-8E
	for linuxppc-embedded@ozlabs.org; Thu, 12 Oct 2006 12:34:38 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
Date: Thu, 12 Oct 2006 12:34:38 +0200
In-Reply-To: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	(David Bolcsfoldi's message of "Tue, 10 Oct 2006 13:49:08 -0700")
Message-ID: <87ac41esap.fsf@sleipner.barco.com>
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

>>>>> "David" == David Bolcsfoldi <dbolcsfoldi@gmail.com> writes:

Hi David,

David> here's a set of patches that adds support for Xilinx UART lite
David> devices. It has been tested on an ML403-FX using xapp902
David> (ml403_ppc_plb_temac) using a 2.6.18 kernel and a BusyBox
David> userspace.

I guess you didn't know, but there already exists a uartlite driver!
It unfortunately didn't made it into 2.6.19-rc1 because Russell
stopped maintaining serial stuff, but it's in -mm.

It also has an official lanana.org assigned set of device nodes.

I didn't look at your patch yet, but I think it would be more useful
to add any features missing to my driver than writing yet another
driver (I think we're up to 3 now).

-- 
Bye, Peter Korsgaard
