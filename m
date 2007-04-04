Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 3B08BDDE00
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Apr 2007 00:30:39 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1HZ6VS-0001N8-4k
	for linuxppc-embedded@ozlabs.org; Wed, 04 Apr 2007 16:30:38 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Using Linux 2.6.19 with Xilinx ML405
References: <46125216.2080903@computing.dundee.ac.uk>
	<46128E70.50503@ru.mvista.com>
	<46139148.1080308@computing.dundee.ac.uk>
	<4613AE3B.2010803@ru.mvista.com>
Date: Wed, 04 Apr 2007 16:30:38 +0200
In-Reply-To: <4613AE3B.2010803@ru.mvista.com> (Andrei Konovalov's message of
	"Wed, 04 Apr 2007 17:55:07 +0400")
Message-ID: <87wt0sp5yp.fsf@sleipner.barco.com>
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

>>>>> "AK" == Andrei Konovalov <akonovalov@ru.mvista.com> writes:

Hi,

AK> At the moment there is no uartlite driver accepted into the
AK> mainline (or whatever community) tree.  There were several
AK> postings to this list. Can't recall if the final patch has been
AK> attached to any of them. But at least people were saying they have
AK> the driver almost ready to go to the community.  MontaVista has
AK> UARTlite driver in Pro 4.0 release, but it is not platform device
AK> (yet), and I'd prefer not to publish it until it becomes a
AK> platform device. And it probably should not use generic_serial.c
AK> any more (the current one does).

My uartlite driver is in mainline since 2.6.20.

-- 
Bye, Peter Korsgaard
