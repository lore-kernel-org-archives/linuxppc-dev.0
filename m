Message-ID: <3A7DE15B.8D033AA8@chello.nl>
Date: Mon, 05 Feb 2001 00:10:19 +0100
From: "b.stolk" <b.stolk@chello.nl>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, erbenson@alaska.net
Subject: Re: incomplete asm-ppc/errno.h in 2.4.1 kernel. 
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Ethan Benson wrote:
>On Sun, Feb 04, 2001 at 04:13:32PM +0100, b.stolk wrote:
>>
>> Hi there,
>>
>>
>> I'm trying to build 2.4.1 with reiserfs on my Motorola PowerStack II.
>
>don't bother, reiserfs does not work on either 64 bit or big endian
>archechures.  (basically anything but x86)

>From the FAQ at namesys I understand that ReiserFS works on alpha.
Alpha is as 64bit as it gets....
Not only has is sizeof(void *)==8, but even sizeof(bool) is 8 :-)
(imagine that: using 64 bits to store a single one!)

>> But: EHASHCOLLISION seems to be missing from include/asm-ppc/errno.h
>> It's present in asm-alpha and asm-i386
>>
>> Anyone working on reiserfs support for ppc at the moment?
>>
>
>jeffm of suse is working on it, he has it to where any attempt to
>write to a reiserfs causes an immediate kernel panic.
>
>see http://penguinppc.org/~jeffm/  for status updates on this.

Thanks for the info,

So far, I got 2.4.1 to build, but the init of my ncr scsi controller
no longer works, so for the time being, I'm bound to a 2.2 kernel.

   Bram Stolk

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
