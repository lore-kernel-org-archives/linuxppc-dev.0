Message-ID: <38CAC92A.5F4B4CFF@denise.shiny.it>
Date: Sat, 11 Mar 2000 17:31:06 -0500
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: Sean Harding <sharding@dogcow.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: compiler optimization? something else?
References: <4.3.2.20000309152803.00ca9100@mail.munich.netsurf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> >juliet ~
> >27% gcc --version
> >egcs-2.91.66
>
> Upgrade to gcc-2.95.2, <ftp://devel.linuxppc.org/users/fsirl/R5/RPMS/ppc/>.
> Though I don't believe this will give you a really big improvement in code
> optimization, it is a big step forward in compiler correctness on PPC.

I don't see any speed improvement from egcs-1.1.12 to gcc 2.95.2. Various
tests done with lame and mpg123 show than 2.95.2 produces code only 0.5%
faster or so. Executable size is 10-15% smaller.

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
