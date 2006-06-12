Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id E7A0B67A6F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Jun 2006 18:03:02 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1FphH2-0005l1-GE
	for linuxppc-embedded@ozlabs.org; Mon, 12 Jun 2006 09:55:48 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Using RS232 Terminal as input device
References: <OF62BECBA0.4F3D8E04-ONC1257185.00247B21-C1257185.002CC13C@rockwellcollins.com>
	<Pine.LNX.4.60.0606070017490.3970@poirot.grange>
Date: Mon, 12 Jun 2006 09:55:48 +0200
In-Reply-To: <Pine.LNX.4.60.0606070017490.3970@poirot.grange> (Guennadi
	Liakhovetski's message of "Sun, 11 Jun 2006 21:51:20 +0200")
Message-ID: <8764j6n6yj.fsf@sleipner.barco.com>
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

>>>>> "Guennadi" == Guennadi Liakhovetski <g.liakhovetski@gmx.de> writes:

Hi,

Guennadi> Or, probably, an easier option - write a user-space daemon
Guennadi> that reads from /dev/ttyS0 and sends events to uinput. With
Guennadi> this you don't need any kernel drivers - just a user-space
Guennadi> daemon.

handhelds.org's kbdd is such a daemon. See
http://handhelds.org/cgi-bin/cvsweb.cgi/apps/kbdd/

-- 
Bye, Peter Korsgaard
