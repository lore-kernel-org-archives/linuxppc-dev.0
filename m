Message-ID: <XFMail.20031114114053.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <1068721518.23764.84.camel@newt>
Date: Fri, 14 Nov 2003 11:40:53 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Adrian Cox <adrian@humboldt.co.uk>
Subject: RE: New 745x errata
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 13-Nov-2003 Adrian Cox wrote:
>
> Since October there are new errata on Motorola's website for the 745x
> family processors. The following patch against linuxppc-2.4-devel
> contains workarounds to two problems:
>
> 1) The BTIC doesn't work reliably: it can cause execution of corrupted
> instructions. (This is listed in the errata for the 7450 and 7457, but
> not for the 7455. I'll only believe that the 7455 escaped this bug if I
> hear confirmation out of Motorola.)

Did you try to ask them about it ?

> 2) dcbt to protected addresses can cause spurious bus cycles. This could
> potentially be exploited from userspace to lock up hardware.

Hm, a 1-cycle window this is very small.  Anyway, if dc* instructions are
used inside the kernel, we could keep them disabled in userspace only.


--
Giuliano.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
