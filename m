Message-ID: <3C0E5679.4060407@embeddededge.com>
Date: Wed, 05 Dec 2001 12:16:41 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Shie Erlich <shie_e@elbit.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 64 bit memory access - again ...
References: <937610FE9B70D511B3E700508B8B65770E53DC@MAIL1>
Content-Type: text/plain; charset=windows-1255; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Shie Erlich wrote:


> the FPU solution does work, however (and thanks for the pointers) - but if
> my
> function saves the fpu registers and restores them, do i really need to
> force
> the kernel to context switch the fpu ?

You have to be careful that moving the bits in/out of the FP register
doesn't have other side effects in FP status or condition codes.  Always
saving/restoring the context will guarantee the application doesn't see
these side effects, but you can experiment if you wish.

Good Luck.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
