Message-ID: <20000524134451.C9100@lx.c-side.com>
Date: Wed, 24 May 2000 13:44:51 -0700
From: Neil Russell <caret@c-side.com>
To: diekema_jon <diekema@bucks.si.com>
Cc: all@cideas.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating Point problems with Linux on the EST SBC8260
References: <m12uh7W-001SyaC@bucks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m12uh7W-001SyaC@bucks>; from diekema_jon on Wed, May 24, 2000 at 03:47:10PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Oops, let's try that again...

I tried this on my board.  I'm running 2.2.14 the SBC8260 and some other
hardware.  I ran the code you posted and it produced exactly the results
that it should have.

The word I have from Motorola is that rev A.1 8260's have a full FPU,
whereas prior version do not.  My experiences confirm this.

Also, I don't cross compile;  I use a G3 MAC running linux.  I wonder if
this makes a difference?


Neil.




On Wed, May 24, 2000 at 03:47:10PM -0400, diekema_jon wrote:
> Floating Point problems with Linux on the EST SBC8260:
>
>
>
>
> The expected results should look something like:
>
> dell 420} ./a.out
> x 1234.330000 (1234.33) 0xEB851EB8
> y 4444.200000 (4444.2)  0x33333333
> z = x * y, 1234.330000 4444.200000 5485609.386000
> z = x / y, 1234.330000 4444.200000 0.277740
>
> We aren't even close to reasonable answers yet.
>

--
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
