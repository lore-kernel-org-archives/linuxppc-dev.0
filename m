To: David de =?iso-8859-1?Q?Andr=E9s=20Mart=EDnez?= <ddandres@disca.upv.es>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: LinuxPPC for MPC555? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 13 Jan 2002 13:18:08 +0100."
             <3C417B00.A0DCAE7@disca.upv.es>
Date: Mon, 14 Jan 2002 13:33:50 +0100
Message-Id: <20020114123355.B211B10B6C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C417B00.A0DCAE7@disca.upv.es> you wrote:
>
> I know it's a bit strange, but we are looking for a LinuxPPC port for
> the Motorola MPC555.
>
> Does anyone know where can we find this port, or if it can be easily
> done?

The MPC555 has no MMU, so LinuxPPC cannot be ported to it.

You might check out uClinux which  works  on  MMU-less  systems,  but
AFAIK there has been only some talk of a uClinux port for the MPC555,
but  I  haven't  seen  any  indication  that anybody actually started
working on it.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A supercomputer is a machine that runs an endless loop in 2 seconds.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
