From: linas@austin.ibm.com
Date: Thu, 5 Jun 2003 17:25:50 -0500
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel patch for arch/ppc/kernel/gen550_dbg.c
Message-ID: <20030605172550.A23648@forte.austin.ibm.com>
References: <3EDFBA42.3050306@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3EDFBA42.3050306@mvista.com>; from mgreer@mvista.com on Thu, Jun 05, 2003 at 02:46:42PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 05, 2003 at 02:46:42PM -0700, Mark A. Greer wrote:
> This patch add in the check to see if the UART already appears to be
[...]
> +	 * We assume that no-one uses less than 110 baud or
> +	 * less than 7 bits per character these days.
> +	 *  -- paulus.

'These days' is a relative term, but last I looked, a few years ago,
I still had a freind who was using a 6-bit airline protocol on a
synchronoous serial port.

Yes, 6-bits means capital letters only.  (26 alpha + 10 num + misc=64)

The protocol was still being used in many travel agencies to support
older terminals.  Our travel agency received it encapsulated in
TCP on top of frame-relay.  The airlines provides a router which
sucks in frame-relay, and spits out 6-bit synch. serial.  We used
a serial cable to hook up a linux box, and converted the 6-bit
protocol into the tcp over ethernet that we wanted.

Thought you might enjoy reading this.  I'll skip over the detailed
description of the four different end-of-message markers in the protocol.


--linas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
