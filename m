Message-Id: <v03110700b4eeeb194579@[129.100.29.243]>
In-Reply-To: <Pine.LNX.4.21.0003101831430.19076-100000@idd-01.imbc.gr>
References: <v03110700b4eec4979817@[129.100.29.243]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 10 Mar 2000 13:17:30 -0500
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp
    cwithr128
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

>> So we should probably get some official patch out there that includes a few
>> elements:
>>
>
>  What do you mean by official ? The next xfree86 update will have
>this fix what more official do you suggest ?
>
>> 1. Either:
>>        - user defined cache line size during compile
>>    or:
>>        - flush a cache range in address increments of 8
>>
>> to handle the variable line cache size

I am confused.  Now that XF 4.0 is out, will quick snapshots continue to be
released?

I just assumed that we would start getting incremental releases 4.0.1,
4.0.2 that would be long in coming (months or more...just like the 3.3.X
series).  If snapshots will continue coming fast, then you are right.  If
snapshots will not be coming (or minor updates will take a few months to
get working), then perhaps an official patch put on the www.linuxppc.org
site or something for Robert Shaw's page so that others who build XF 4.0
from source will have something to fix the cache problems with.

How about just a patch that fixes cache flushing for XFree 4.0 which
assumes cacke line sizes of 16 and ignores 601 problems then that we just
send to the linuxppc-dev mailing list so that it gets archived.

>  Glibc assumes a line size of 16 so that will be ok, in any
>case the cache flush will be used only in the startup of the
>xserver not need to worry about a few extra instructions there
>so we can live even with 4byte increments, definitely better than
>a compile time option.

>   Hmm i don't think that xfree86 4.0 will work under mklinux, there
>aren't any drivers that will work under mk anymore (xpmac is gone and
>the vgahw/fbdev based ones won't work).

Is this true?  So we don't have to worry about 601 processors at all?

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
