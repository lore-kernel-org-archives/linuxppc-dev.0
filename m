Message-ID: <39D42B66.56AC7D7D@mvista.com>
Date: Fri, 29 Sep 2000 01:40:54 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <19340822040932.8760@mailhost.mipsys.com>
		<Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
		<14803.57550.118150.759977@argo.linuxcare.com.au>
		<39D41AA2.C586D738@mvista.com> <14804.7238.688771.238444@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> Because we'll make it the same value for all ports.  Anybody got any
> objections to 0xff000000?

You know I will :-).  Most of the embedded processors already map
internal resources in this space, which of course can be changed.  You
know one of the reasons we map legacy I/O 1:1 to the processor is for
debug and initialization.

Why don't you pick an address like 0x80000000?  This will work on at
least some existing platforms without any changes (Prep, Chrp, and
embeddded come to mind :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
