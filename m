To: Reza Salehi <salehirp@yahoo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Question - loading and running u-boot from RAM 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 14 Jul 2004 13:42:09 PDT."
             <20040714204209.33193.qmail@web61104.mail.yahoo.com>
Date: Wed, 14 Jul 2004 23:51:51 +0200
Message-Id: <20040714215156.AFA90C109F@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20040714204209.33193.qmail@web61104.mail.yahoo.com> you wrote:
>
>
> I am  newbie to this list and linux.  Let me start by

You introduce yourself with an off-topic posting.
U-Boot related questions do not belong on the linuxppc-dev list.
Please post such stuff to u-boot-users instead.

> saying that I know that my question is FAQ and I have
> read the archives.  However, I would still like to

You did?

> know if some one can outline what needs to be changed
> (configuration and code) in order to be able to build
> a u-boot binary that can be loaded into SDRAM and
> executed from their.

This has been discussed many times on the u-boot-users mailing  list.
I'm absolutely sure you can find it there in the archives.

> 1.  I am working for a very smal company that can not
> afford low level debuggers.  And therefore, every time

Divide the price for a BDI2000  by  your  hourly  rate.  _Especially_
since  you are a beginner you will find (probably not now, but later)
that it is cheaper to buy the right tools for the job. Not to mention
the time-to-market factor.

> 2.  The board I am using has socket for the flash, and
> socket is flaky.  Therefore, when there is a problem,
> I don't know if it is the socket or the code I
> changed.

That's one more reason to use a BDI2000 which allows to  program  the
flash in situ (even if soldered on).

>  But after that I would like to boot my system from
> flash and tftp my test u-boot image into SDRAM and run
> it from their.  Once I know my code is working, then I
> can go ahead and burn the new u-boot image into flash.

Exactly this will not happen. The changes you have to  make  to  boot
from  RAM  need  to be reverted to boot from flash, and there is zero
guarantee that the code will continue to work.

> I am using MPC8540 and u-boot 1.1.1.
>
> I realize that this is a subject that has been talked
> about before.  However, I believe(as newbie) that if
> someone can outline this process, it can be big help
> to developers with less budget and tools to work with.

You are wrong. It doesn't help. If you have a lot of  experience  and
know exactly what you are doing, you can try something like this, and
it  may  even  be  efficient  in  some situations. But even then (and
especially then) you will want to use the right tools. And without  a
lot of experience, well, you will need veerryyyyy much time.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Let's say the docs present a simplified view of reality...    :-)
                      - Larry Wall in  <6940@jpl-devvax.JPL.NASA.GOV>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
