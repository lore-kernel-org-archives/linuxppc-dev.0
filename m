From: kd@flaga.is
Subject: Re: zeroing of bss segments
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF545F1DB8.1BC9109A-ON002568C3.00596043@flaga.is>
Date: Sun, 16 Apr 2000 16:19:38 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Duhhhhh,

I forgot to remove th memset.S file from sysdeps/powerpc....

That was causing me all the headache. Thanks for reminding me, before I
reimplemented binfmt_elf.c in the kernel 8-)

Thanks again!

K.D.

Marcus Sundberg wrote:


>kd@flaga.is writes:
>
>> Well if you are talking about floating point patch and the cache line
size
>> patch then I have them applied.
>> Are there any other patched floating around that are necessay for the
>> mpc823?
>
>No, I was referring to the cache line size patch (including removing
>memset.S) as your problem sounded like what one can experience
>without it. No idea then.
>
>//Marcus

--
When someting is not working reread the instructions......

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
