Message-Id: <200005121905.PAA25004@mal-ach.watson.ibm.com>
To: David Weis <djweis@plconline.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: some booting help 
In-Reply-To: Message from David Weis <djweis@plconline.com>
   of "Fri, 12 May 2000 13:50:43 CDT." <Pine.LNX.4.10.10005121349370.13573-100000@catbert.desm.plconline.com>
Date: Fri, 12 May 2000 15:05:06 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> David Weis writes:

David> I was looking at the BUSIO_ATT and BUSIO_DET functions in
David> /usr/include/sys/adspace.h for clues. I had downloaded some AIX driver
David> source code examples once but can't seem to find them any more.

	See also /usr/include/sys/ioacc.h.  AIX device drivers accessing
those types of devices perform a lot of

iocc_val = IOCC_ATT(bus_id, 0);
val = BUSIO_GETC(iocc_val+XXX);
...
BUSIO_PUTC(iocc_val+XXX);
IOCC_DET(iocc_val);

	Plus programmed I/O, e.g., pio_assist().

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
