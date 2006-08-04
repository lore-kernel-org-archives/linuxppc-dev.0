Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 53A0B679E7
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Aug 2006 00:27:59 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1G90EP-0002Ac-LN
	for linuxppc-embedded@ozlabs.org; Fri, 04 Aug 2006 16:00:54 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: XUPV2P, Kernel 2.6.17 boot problem
References: <20060801100220.26176938@bob.dt.e-technik.uni-dortmund.de>
	<44D1021C.5080602@dlasys.net>
Date: Fri, 04 Aug 2006 16:00:52 +0200
In-Reply-To: <44D1021C.5080602@dlasys.net> (David H. Lynch, Jr.'s message of
	"Wed, 2 Aug 2006 21:50:52 +0200")
Message-ID: <87irl8zjl7.fsf@sleipner.barco.com>
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

>>>>> "DHL" == David H Lynch <dhlii@dlasys.net> writes:

>> Linux/PPC load: console=ttyS0,9600.....
>> 
>> Uncompressing Linux...inflate returned FFFFFFFB exit
>> 

DHL>     Zlib was upgraded with 2.6.17. The updated Zlib is broken on
DHL> ppc32.  I am pretty certain it is fixed in 2.6.18-rc3

No, that was ony added in 2.6.18-rc1 (and the fix was only added
post-rc3), so that can't be it..

-- 
Bye, Peter Korsgaard
