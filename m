Message-ID: <3C0ECCD7.8060308@acm.org>
Date: Wed, 05 Dec 2001 19:41:43 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Changes to PPC Linux required for GCC 3.1
References: <5.1.0.14.2.20011205134825.024d8ed8@mail.lauterbach.com> <3C0E48D2.6000409@acm.org> <200112052146.16467@enzo.bigblue.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:

>On Wednesday 05 December 2001 17:18, Corey Minyard wrote:
>
>>Franz Sirl wrote:
>>
>>>Ah, I see, I only saw this problem in aty128fb. I'll add the fix to
>>>the linuxconsole CVS for 2.5.x.
>>>
>>What about 2.4?  I'm sure people will want to compile 2.4 with gcc 3.x.
>>
>
>That has to go thru the usual channels.
>
And that is ....?

>
>Nope, probably I should add one, cause I don't have time to continue with a
>divdi3_32 pattern anytime soon :-(.
>
It would be pretty easy to copy it from libgcc2.  You don't want to do
this by hand, it's big and nasty in C, in assembly it would be a
nightmare.  You would have to do some license massaging, though, because
libgcc2.c is GPL with special provisions.  I can look at gcc, but it's
hard to tell how long something like that takes to find.

-Corey


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
