From: Jesper Skov <jskov@redhat.com>
Message-ID: <14497.10437.498606.647038@thinktwice.zoftcorp.dk>
Date: Wed, 9 Feb 2000 09:43:49 +0100 (CET)
To: Peter Allworth <linsol@zeta.org.au>
Cc: Jesper Skov <jskov@redhat.com>, duncanp@research.canon.com.au,
        linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Low memory problems in 8xx Linux
In-Reply-To: <38A0AE0D.2EB99353@zeta.org.au>
References: <20000201235813.4F5611B51A@elph.research.canon.com.au>
	<38977960.40E014A1@zeta.org.au>
	<ot1z6of1ws.fsf@thinktwice.zoftcorp.dk>
	<38A0AE0D.2EB99353@zeta.org.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Peter" == Peter Allworth <linsol@zeta.org.au> writes:

Peter> Jesper Skov wrote:
>>  >>>>> "Peter" == Peter Allworth <linsol@zeta.org.au> writes:

Peter> <snip>

Peter> If you need the MMU patches straight-away, I've put them on
>>
Peter> http://www.zeta.org.au/~linsol
>>
Peter> They only work against cllf-2.2.13 for now. Marcus Sundberg has
Peter> sent me a revised patch which should work for other 2.2 kernels
Peter> (caveat emptor).  I'll try to add that asap.
>>  Peter and Duncan,
>>
>> The 2.2.13 patch you posted was slightly (but critically) wrong, if
>> I'm not mistaken. The value updated in memory was not reloaded into
>> r21 which is where the code below this snipped expects to find the
>> value.
>>
>> This patch should do the trick. At least my kernel seems to work.

Peter> Jesper,

Peter> Which kernel are you using and which patch file?  (Please
Peter> double-check the readme.txt file.)

I was assuming one of the patches was for
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/mpc8xx-2.2.13.tgz, but
I don't think either matches very well.

Peter> My http://www.zeta.org.au/~linsol directory contains two
Peter> versions of the patch to head.S. If you are using cllf-2.2.13
Peter> which includes the use of r21 as you've described, then use
Peter> "head.S-patch".

Peter> Marcus Sundberg provided the other file "head.S.non-cllf" which
Peter> is for older kernels that used r20 for the pte and didn't do
Peter> the update of the GUARDED bit. (I need to change the names in
Peter> the diff headers to make this clearer.)

I read the patch and think I understand what's going on, but I don't
see where the GUARDED bits comes in. Maybe I'm missing some subtlety
from other patches (cllf?) and should not use the code at all. I'd
better back it out.

Jesper

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
