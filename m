Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 5CAEB67B66
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Sep 2006 17:55:43 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1GRlJB-0007tj-RH
	for linuxppc-embedded@ozlabs.org; Mon, 25 Sep 2006 09:55:21 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Booting problems
References: <451608B7.9010707@dlasys.net>
Date: Mon, 25 Sep 2006 09:55:21 +0200
In-Reply-To: <451608B7.9010707@dlasys.net> (David H. Lynch, Jr.'s message of
	"Sun, 24 Sep 2006 06:25:27 +0200")
Message-ID: <87hcywv0ra.fsf@sleipner.barco.com>
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

David>     I have tried blindly jiggering with the
David> CONFIG_ADVANCED_OPTIONS setting with no noticable effect.  The
David> total zImage.elf size is just shy of 3Mb.

David>     Does anyone have an idea what I need to do to be able to
David> load a larger image ?

How big is your vmlinux? I guess you are running into the 4MB limit.

See the recent thread about it:
http://ozlabs.org/pipermail/linuxppc-embedded/2006-August/023977.html

-- 
Bye, Peter Korsgaard
