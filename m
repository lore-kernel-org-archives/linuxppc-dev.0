To: Pedro Parrilla <pparrilla@prodys.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Rx problems with IDMA on MPC860... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 08 May 2003 09:47:58 +0200."
             <3EBA0BAE.93167851@prodys.net>
Date: Thu, 08 May 2003 11:34:24 +0200
Message-Id: <20030508093429.6BF3CC6092@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3EBA0BAE.93167851@prodys.net> you wrote:
>
>     I'm working on a MPC860T. I've been trying to receive from a
> peripheral via IDMA and it seems to work OK, but when I study data
> received from IDMA I can see that there are some bytes at the end of
> each IDMA buffer received that are wrong, in fact they haven't been
> written to the buffer and previous bytes remain; but interrupts are
> received Ok, and the number of read bytes in the peripheral are the IDMA
> set.

Are you sure you got the cache handling right?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If in any problem you find yourself doing an immense amount of  work,
the answer can be obtained by simple inspection.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
