Message-ID: <XFMail.990611232427.heinz@bintec.de>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <199906111644.SAA06210@denx.muc.de>
Date: Fri, 11 Jun 1999 23:24:27 +0200 (CEST)
From: Heinz Blaettner <heinz@bintec.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Help booting MBX through bootd
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 11-Jun-99 Wolfgang Denk wrote:
>> The fact that the cache magic in sysdeps/powerpc/memset.S in glibc
>> will make the dynamic linker crash in it's early startup phase is
>> quite a big problem... ;)
>> Also sysdeps/powerpc/dl-machine.c makes an assumption about the cache
>> line size, but that seems to be less fatal.
> 
> Grrrghh... I see.

Maybe a thumb question ?
How does the wrong cache line size makes that the code corrupts ???
I will belive that the execution speed might not be optimal ?

Can someone throw some light on this I don't understand this behaviour ?

...

Thanks

heinz

___________________________________________________
Command, n.:
        Statement presented by a human and accepted by a computer in
        such a manner as to make the human feel as if he is in control.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
