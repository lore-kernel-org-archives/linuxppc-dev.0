Message-ID: <3CC9CF85.2030506@pacbell.net>
Date: Fri, 26 Apr 2002 15:07:01 -0700
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: John Tyner <jtyner@cs.ucr.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: oops in arch/ppc/kernel/ocp.c
References: <Pine.LNX.4.30.0204261416440.16519-100000@hill.cs.ucr.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Tyner wrote:
> Our 405's are oops'ing in arch/ppc/kernel/ocp.c:
>
> max is unitialized if EMAC_NUMS is defined to be less than or equal to 1.
>
> ocp_register is returning 2 when it should be registering eth0 (and
> returning 0).
>
>
>
>
>

Thats been fixed and been sent in

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
