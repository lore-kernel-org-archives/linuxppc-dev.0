To: Gabriel Paubert <paubert@iram.es>
Cc: "Srinivas Rao.M" <msrao@vxl.co.in>,
	Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: speed and space Optimization 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 08 Mar 2001 15:54:16 +0100."
             <Pine.HPX.4.10.10103081551290.9166-100000@gra-ux1.iram.es>
Date: Thu, 08 Mar 2001 18:18:01 +0100
Message-Id: <20010308171806.B446B281E1@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.HPX.4.10.10103081551290.9166-100000@gra-ux1.iram.es> you wrote:
>
> Actually, the gcc code generation of PPC lacks in this area. There are
> very few differences between -O2 -Os (first one is the standard for speed
> although you might want to try -O3). -Os is in theory the space
> optimization, but there are very few places in the rs6000/ppc description
> that depend on whether the code should be optimized for space or not.
> There will be some difference, but relatively very small.

Just tested on our PPCBoot firmware:

   text    data     bss     dec     hex filename	==> size
  80628   22096   10476  113200   1ba30 ppcboot-Os	100%
  86332   22096   10476  118904   1d078 ppcboot-O2	105%
  90464   22328   10476  123268   1e184 ppcboot-O3	109%

Differences are  small,  but  they  exist  (and  they  can  make  the
difference if the code fits in a 128k boot ROM or not).


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Hindsight is an exact science.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
