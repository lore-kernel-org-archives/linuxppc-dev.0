Message-ID: <3CA8100C.2090203@pacbell.net>
Date: Mon, 01 Apr 2002 07:45:16 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: ashish anand <ppc4@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: any pointer...?
References: <20020401130105.30420.qmail@mailweb11.rediffmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ashish anand wrote:
>
> I have a specific problem in 405gp on embeddedplanet board.
>
> it is gets hanged in MEMCPY() below.
>
> void __init
> Board_init(unsigned long r3, unsigned long r4, unsigned
> long r5,unsigned long r6, unsigned long r7)
> {
>         /*
>          * If we were passed in a board information, copy it into
> the
>          * residual data area.
>          */
>         if (r3) {
>          memcpy((void *)__res, (void *)(r3 +KERNELBASE),
>   sizeof(bd_t));
>         }
>
> i am using board reset ( bl reset) type of macro for debugging for
> detemining the hang .
>
> if i put bl reset  macro before memcpy the board gets reset but
> not after the memcpy .
>
> abort being ..._GLOBAL(abort)
>                mfspr   r13,SPRN_DBCR
>                oris   r13,r13,DBCR_RST(DBCR_RST_SYSTEM)@h
>                mtspr   SPRN_DBCR,r13
>
>
> can anybody help me with any pointer....
>
>
>

Looks like you are using an older kernel (2.4.2 ish).  You should pull
from the latest devel.  I have used the ep405 as have a few others.

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
