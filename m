Date: Thu, 8 Mar 2001 16:48:21 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: "Srinivas Rao.M" <msrao@vxl.co.in>
Cc: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: speed and space Optimization 
In-Reply-To: <Pine.SCO.3.91.1010308204511.15429B-100000@vayudoot>
Message-ID: <Pine.HPX.4.10.10103081631390.9166-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 8 Mar 2001, Srinivas Rao.M wrote:

>
> Ok. thanks for the reply Mr. Gabriel. How can i do the bench marking of
> these options. Can i get some more information from somewhere on net.
> -Srini...

Try "info gcc" for the optimization and machine specific options. There
are also specialized gcc mailing lists, but first read the documentation
before bothering the people on the lists.

The best benchmark is *always* the code that you want to run. On my tests
the difference between size and speed optimizations was always small
(although above the noise level), and sometimes surprising (-Os was faster
than -O2 which was faster than -O3 for some routines). The only thing you
can count on is that -O0 will generate the biggest and slowest code by
far, -O1 will make it already much smaller and faster, but still
noticeably slower than any of the higher optimization options.

But every application is different and you might notice a bigger impact
than me depending on processor and compiler options (I did these tests
about 18 months ago, compiler has improved since then but of course not as
much as we would like).

Lies, damn lies, statistics, and benchmarks...

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
