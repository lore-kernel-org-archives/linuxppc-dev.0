To: Jaap-Jan Boor <jjboor@lucent.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: occasionally segmentation faults 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 08 Aug 2002 15:45:34 +0200."
             <200208081345.PAA08157@hzsms01.nl.lucent.com>
Date: Thu, 08 Aug 2002 22:12:28 +0200
Message-Id: <20020808201233.91B7210DE1@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jaap-Jan,

in message <200208081345.PAA08157@hzsms01.nl.lucent.com> you wrote:
>
> then I downloaded and installed you eldk, but still
> have sometimes the segmentation fault.
>
> My kernel is under suspicion now. I saw eldk also

This is exactly what I suspeect, too.

> contains a 2.4.4 kernel (I use 2.4.10)

We were never able to get 2.4.10 stable (or any other version between
some 2.4.7 and 2.4.14 or so).

> Did you apply something else then the uart changes to it?

Well, yes. There are many extensions / changes / fixes in our  kernel
source tree.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
      Bugs are by far the largest and  most successful class of
      entity, with nearly a million known species. In this res-
      pect they outnumber all the other  known  creatures about
      four to one.  -- Professor Snope's Encyclopedia of Animal

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
