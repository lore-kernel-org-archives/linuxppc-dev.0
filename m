Message-Id: <200104181129.HAA07606@odonnell.lowell.mclinux.com>
To: linuxppc-embedded@lists.linuxppc.org
From: mod+linuxppc-embedded@std.com
Subject: Re: Possible bug in serial.c?
Date: Wed, 18 Apr 2001 07:29:24 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Since 'i' is an index into the rs_table[], shouldn't this be:
>
>        if (i >= NR_PORTS)
>                return(-ENOENT);


Speaking of rs_table[] and such, I'd be grateful for a
clear explanation of the async_struct and serial_state
structs - what are each intended for?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
