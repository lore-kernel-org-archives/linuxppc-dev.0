Message-ID: <39FF6FDD.50DFBE38@mvista.com>
Date: Tue, 31 Oct 2000 20:20:29 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        paulus@linuxcare.com.au
Subject: Re: 2.2.18pre17 again
References: <Pine.HPX.4.10.10010311722330.15431-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
>
> On Tue, 31 Oct 2000, Benjamin Herrenschmidt wrote:
>


> > Because you didn't implement it yet ? :)
>
> Perhaps...

Make sure you look at the code in the "boot" directories.  I think
all of them have udelay functions that use the timebase.  At least,
it would be a starting point.

> Even with a 33 MHz timebase (keep dreaming), the maximal delay for non
> 601 CPUs is over 100 seconds.

I thought at one time we had mdelay/udelay that were smart enough
to loop and call the lower level delay to ensure this maximum
delay wasn't exceeded.....maybe I was smoking something :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
