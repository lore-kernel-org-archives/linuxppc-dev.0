Message-ID: <3C0527AF.9CA07809@mvista.com>
Date: Wed, 28 Nov 2001 10:06:39 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Platform files question
References: <0111281640.AA27241@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:
>
> Hi there,
>
> Now that we have arch/ppc/platforms and include/asm-ppc/platforms for all
> platform-specific files, I have this question for you guys. When I do a new
> platform port, should I put the main .h file for the platform in
> arch/ppc/platforms or in include/asm-ppc/platforms?
>
> MS
>


AFAIK your board header should go in include/asm-ppc/platforms and your
board.c file should go arch/ppc/platforms

-- armin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
