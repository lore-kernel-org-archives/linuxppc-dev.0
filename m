To: "Santosh Raj B" <santosh@ematrixtech.com>
Cc: "emb linux" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BSP for ppc750 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 07 Nov 2003 17:40:24 +0530."
             <00c101c3a535$638ab3f0$0100a8c0@rnd>
Date: Fri, 07 Nov 2003 14:56:16 +0100
Message-Id: <20031107135621.1323FC5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <00c101c3a535$638ab3f0$0100a8c0@rnd> you wrote:
>
> Any clues on differences b/w ppc750 and mpc750. I have a PPC750 board but a
> MPC750 BSP, could I use this BSP

As the name BSP (= BOARD support package) suggests a BSP  deals  with
the special features of a board, not with a specific processor model.
You  cannot  use  a  BSP  for  one  board on another, different board
without  making  certain  modifications  (a  process   often   called
"porting")  -  no  matter  if the two bards use the same processor or
not. [Well, it may be easier if both use the same CPU.]

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It's when they say 2 + 2 = 5 that I begin to argue."    - Eric Pepke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
