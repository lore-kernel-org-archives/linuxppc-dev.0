Subject: Re: how to pass kernel command parameters?
From: Gary Thomas <gary@mlbassoc.com>
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <p06010202bc333bc03e48@[192.168.9.5]>
References: <p06010202bc333bc03e48@[192.168.9.5]>
Content-Type: text/plain
Message-Id: <1074630928.26813.599.camel@hermes>
Mime-Version: 1.0
Date: Tue, 20 Jan 2004 13:35:29 -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-01-20 at 13:27, Stefan Jeglinski wrote:
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

The default kernel command line can be easily configured using the
standard configuration tools (e.g. make xconfig)  This string gets
built into the kernel image and can later be overridden on the console.

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
