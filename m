Message-ID: <3C91DF80.4040904@pacbell.net>
Date: Fri, 15 Mar 2002 11:48:16 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] another for ibm_ocp_enet
References: <20020314222859.A24861@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:
> This patch includes the last patch that I sent before the
> directory move, plus some more stuff.
>
> 1. Fix merge error with MAX_NUM_PHYS in find phy loop.
> (the for loop condition should match the if check)
>
> 2. Fix bad Partner Link check for the added Phy.
>
> 3. added mal.sh to generate a new ibm_ocp_mal.c
> 	mal.sh  DCRN_MAL_BASE >ibm_ocp_mal.c
> or	mal.sh  DCRN_MAL_BASE DCRN_MAL1_BASE >ibm_ocp_mal.c
> will work. It seems that the second on generates a smaller
> object file even though the code is bigger for the 405GP.
> I would think it is because MAL1 is 0.
> This condenses all the get/set mal calls into one for get
> and one for set. I also changed mal_num to mal, just to help
> me find/change things.

The script idea is cool.

The mal_num is more descriptive to me so give me a better argument

>
> I think this is a better approach than what was in the _mal.c,
> but I didn't change the makefile to generate the code on the
> fly yet.
>
> 4. Added skb_res as a module param and config.in option.
>
> 5. Created rx_clean/fill functions to remove duplicate code
> in open and the 2 rx interrupts.
>
> 6. Handle dev_alloc failures better by retrying to alloc before
> the rxde interrupt.
>

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
