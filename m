Message-Id: <v04003a00b332e0c87b47@[38.27.133.161]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 8 Apr 1999 18:56:07 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Ben Martz <benmartz@earthlink.net>
Subject: RE: Resurrecting mkLinux
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>On 06-Apr-99 Roy Wood wrote:
>>
>> I've got a little time and an old 6100, so I'm giving some thought to
>> raiding the mkLinux sources and getting a monolithic version of the
>> kernel going (i.e. getting rid of the whole Mach layer).
>>
...
>>
>> Anyway, I was hoping some of you people here might be able to offer
>> advice or have some useful comments about what I'm considering doing.
>>
>> Anybody?  Anyone?
>>
>
>Your biggest problems will be:
>  * Booting - perhaps BootX can be made to help here
>  * Lack of Open Firmware - used to "size up" the hardware
>  * 601 support - biggest worries are actually the in the hardest
>    to debug - boot time and machine initialization.
>
>Other than that, it should work.  Of course, I'm not saying it is
>easy or else I would have done it myself long ago...

Roy,

I have some very old booting code from the defunct PowerOS project that
works just fine on x100 machines. (It was the second public use of the Gary
mode hack that I am aware of, after MkLinux) I also have some more recent
work based on BootX that you may find useful.

http://home.earthlink.net/~benmartz/poweros/

Oh, in case anyone is wondering, you won't find any of the kernel code up
there because I am still working on it =) It's just a little project that I
am doing for my own enjoyment to stretch my mind a little.


----
Ben Martz - benmartz@earthlink.net



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
