Date: Tue, 20 Jan 2004 16:02:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: how to pass kernel command parameters?
Message-ID: <20040120230201.GQ13454@stop.crashing.org>
References: <p06010202bc333bc03e48@[192.168.9.5]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p06010202bc333bc03e48@[192.168.9.5]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 20, 2004 at 03:27:38PM -0500, Stefan Jeglinski wrote:

>
> I have a Brightstar box with an MPC823, booting under 2.4.21 at the
> moment. But at the "Linux/PPC load:" line I have to enter a rather
> long string of parameters (IP numbers etc), I guess due to the boot
> ROM code that's part of this little Brightstar device.
>
> What is the proper way to automate the passing of these parameters?
> I'm gathering that all ppc kernel boots have this line to stop at,
> but the passing of parameters to it is automated.
>
> Should I be constructing a custom ram disk that contains the info? If
> so, what's a good resource about making ram disks and how to do this?
> If not, how is one supposed to do it? I don't suppose one should be
> hard-coding misc-simple.c or misc-embedded.c... ?

All that is needed, via your favorite config target is:
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="everything to pass in"

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
