Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id C61F667C41
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 17:11:45 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1GYHCp-0002ag-6x
	for linuxppc-embedded@ozlabs.org; Fri, 13 Oct 2006 09:11:43 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<609d5c8e0610122221i7c5e5049n4db5fcf3f61bd132@mail.gmail.com>
Date: Fri, 13 Oct 2006 09:11:43 +0200
In-Reply-To: <609d5c8e0610122221i7c5e5049n4db5fcf3f61bd132@mail.gmail.com>
	(David Bolcsfoldi's message of "Thu, 12 Oct 2006 22:21:41 -0700")
Message-ID: <87ac40vgeo.fsf@sleipner.barco.com>
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

David> Here's an initial patch based on a modified uartlite (by Peter
David> Korsgaard), it's by no means ment to be final and any feedback
David> would be appreciated.

Could you make it relative to my driver so the changes are easier to
see?

David> - readb/writeb to in_be32/out_be32.

David> For some reason on my board the readb and writeb don't behave
David> correctly when reading and writing to the uartlite device. I
David> haven't looked into it but if this is unacceptable I will try
David> to revert to readb/writeb.

The PPC is big endian - Did you remember to add 3 to your base
address?

-- 
Bye, Peter Korsgaard
