Message-ID: <3A6CCCBB.270DF241@mvista.com>
Date: Mon, 22 Jan 2001 19:13:47 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Michel Ddnzer <michdaen@iiic.ethz.ch>,
        Benjamin
	Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann
	<jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <3A686DFE.9030308@valinux.com>
		<19341214104258.22601@mailhost.mipsys.com>
		<3A68FC06.7BEEA13D@iiic.ethz.ch>
		<3A691166.DC6DCD81@iiic.ethz.ch> <14956.50865.856754.439761@diego.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> Which means that *pgd == 0, which is very odd indeed, unless of course
> you have run off the end of the vmalloc'd area (I assume you haven't).

Right, I made the same assumption, this was the first time through
the loop.

> What is the value of the symbol swapper_pg_dir in this kernel?

It looks like swapper_pg_dir because of it's low memory address.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
