Date: Fri, 9 Mar 2001 10:47:03 +1100
From: Graham Stoney <greyham@research.canon.com.au>
To: Gabriel Paubert <paubert@iram.es>
Cc: "Srinivas Rao.M" <msrao@vxl.co.in>,
	Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: speed and space Optimization
Message-ID: <20010309104703.B6166@brixi.research.canon.com.au>
References: <Pine.SCO.3.91.1010308204511.15429B-100000@vayudoot> <Pine.HPX.4.10.10103081631390.9166-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.10103081631390.9166-100000@gra-ux1.iram.es>; from paubert@iram.es on Thu, Mar 08, 2001 at 04:48:21PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 08, 2001 at 04:48:21PM +0100, Gabriel Paubert wrote:
> -Os was faster than -O2 which was faster than -O3 for some routines.

I had similar results benchmarking our application on an 855T: -Os was both
smallest and fastest on gcc-2.95.2.  This makes sense since the I-cache on
embedded CPUs is relatively small, and tighter/smaller code takes less time
to fetch.  The difference between -Os and -O2 in terms of speed and space
were only very minor.  -O3 made code larger and slower, by inlining functions
and blowing the cache out too much; I'd strongly recommend against using it.

My suggestion is that the best starting point is to use -Os.

Regards,
Graham
--
Graham Stoney
Assistant Technology Manager
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
