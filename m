Return-Path: <linville@bilbo.tuxdriver.com>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	by ozlabs.org (Postfix) with ESMTP id 4539967A85
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 07:30:01 +1100 (EST)
Date: Tue, 18 Jan 2005 15:29:15 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Message-ID: <20050118202913.GC6883@tuxdriver.com>
References: <313680C9A886D511A06000204840E1CF0A647502@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <313680C9A886D511A06000204840E1CF0A647502@whq-msgusr-02.pit.comms.marconi.com>
Cc: 'Steven Blakeslee' <BlakesleeS@embeddedplanet.com>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: Linux 2.6.10-rc3 8xx: debugging (over-writing) content of b
	d_in fo structure in the kernel booting code
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jan 18, 2005 at 02:08:19PM -0500, Povolotsky, Alexander wrote:
> My board is using:
> 
>         bd->bi_intfreq = 50000000;
>         bd->bi_busfreq = 50000000;
> 
> While RPX-Lite is using
> 
>         bd->bi_intfreq = 48000000;
>         bd->bi_busfreq = 48000000; 
> 
> Is this what makes RPX-Lite work and my (MPC 880) not ?

That, of course, depends on which value is correct for your
board... :-)

When I mentioned in one of our (possibly off-line) exchanges that
_slightly_ incorrect clock speeds might explain how you get a few good
characters from the serial port before you get all that garbage, this
is the kind of descrepancy I was suggesting.  There may be enough
"slop" in the timings of the relatively slow serial port to make
48MHz and 50MHz "close enough" for a few characters.

So, what is the correct number for your board?  Do you know how to
identify an oscillator?  They have a bit of a 'tin can' look to them.
Find the one closest to the CPU on the board, and see what number is
on it.

John
-- 
John W. Linville
linville@tuxdriver.com
