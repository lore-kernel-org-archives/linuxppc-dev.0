To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
In-reply-to: Your message of "Thu, 21 Mar 2002 01:50:21 -0500"
             <3C9982AD.5030502@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 21 Mar 2002 22:05:44 +1100
Message-ID: <6636.1016708744@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 21 Mar 2002 01:50:21 -0500, Dan Malek <dan@embeddededge.com> writes:
>> .... The problem with
>> this method starts when you have a lot of information to pass
>
>I'm going to (constantly :-) argue that if you are passing lots of information
>then something isn't designed correctly.

Then I guess that I am going to (constantly) disagree with you :-)

The more Linux can learn from the boot loader, the more generic the kernel
and the wider the set of hardware a particular kernel will run on without
recompilation.

I disagree with your contention (in another recent message) that this is bloat
and is bad for embedded systems. It actually reduces bloat because code in the
kernel that duplicates things that are done by the boot loader goes away - the
kernel is smaller and more generic, and the code is cleaner (fewer #ifdefs etc)
- and a more generic kernel is more user friendly (i.e. easier for someone
without 20 years Comp. Sci. experience to port).

>It's one thing to be passing a few
>hardware hints or small configuration values, but I think it's quite wrong
>to design a bunch of dynamic software that requires a small data base to be
>passed into to the kernel.

And I think this is what is needed. Just because we have always done it one
way, does not mean it is the right way, or that we have to continue to do it
that way.

>Please don't be confused by this comment and start
>aruging OF device trees on Macs.  The OF tree is really just a bunch of small
>configuration items that allows lots of generic software to run on a variety o
>f
>Mac platforms.

It is clear that (many?) others think along the same lines as I do. Evidence
is the many boot loaders that implement some sort of device tree - the
OpenBoot on my Ultra-60 is a good example. They are all just bunches of
small configuration items, but there might be a lot of them, and/or they might
have complex structure.

However, your position is the default position and requires little work. My
position requires a lot of work and coordination - I don't think it is going
to happen soon, if ever (although benh's posted code was the closest I've seen
yet and looks very promising). Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
