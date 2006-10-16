Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 7B76467C44
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 04:54:31 +1000 (EST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: Recently removed io accessors
References: <873b9twnbb.fsf@sleipner.barco.com>
	<1160697861.4792.177.camel@localhost.localdomain>
	<87iriovh3x.fsf@sleipner.barco.com>
	<1160724670.4792.195.camel@localhost.localdomain>
	<87slhstxlk.fsf@sleipner.barco.com>
	<17712.7972.493547.357685@cargo.ozlabs.ibm.com>
	<8764ent8j4.fsf@sleipner.barco.com>
	<20061016165140.GB6537@austin.ibm.com>
Date: Mon, 16 Oct 2006 20:54:10 +0200
In-Reply-To: <20061016165140.GB6537@austin.ibm.com> (Linas Vepstas's message
	of "Mon, 16 Oct 2006 11:51:40 -0500")
Message-ID: <87vemk6qi5.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "LV" == Linas Vepstas <linas@austin.ibm.com> writes:

Hi,

>> It doesn't have to be readw (16bit accesses). Enabling the BE mode
>> and using _outsl/_insl (32bit access with byteswap) works fine.

LV> I think Paul was trrying to say that it might be easier just to
LV> 16-bit words. Are you trying to use 32-bit access due to
LV> performance concerns?

Yes, this is the hot path of the driver as I don't have DMA hardware
(copy to/from packet buffer).

Another reason is that the same driver is used for the entire 911x
series, some which have an 16bit interface and others with full 32bit.

-- 
Bye, Peter Korsgaard
