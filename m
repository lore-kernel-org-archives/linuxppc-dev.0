Message-ID: <39098B8A.625A85A8@embeddededge.com>
Date: Fri, 28 Apr 2000 09:00:58 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Kim Jørgensen <KIJ@infocom.dk>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems with serial ports
References: <819E3E914E0AD11194DE00805F0D100B0138B840@fbi.infocom.dk>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kim Jørgensen wrote:

> Is the new driver available?

No. It's kind of low on the list of other problems to solve at
the moment.

> I tried to use scc2 as console under startup and smc1 as console by the
> kernel. (I just changed serial_init to serial_scc_init in head.S)

That's only (or less than :-) half of the change.  That is only used
by the Linux bootstrap when requesting command line information and
providing loading status.

> This works ok, I get the startup messages on scc2 and the kernel messages
> and bash prompt on smc1.

That's because I don't yet have the kernel driver part done yet.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
