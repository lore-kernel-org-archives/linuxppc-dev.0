Message-ID: <398E0A86.701B35AB@mandrakesoft.com>
Date: Sun, 06 Aug 2000 21:01:58 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: Tom Gall <gall@rochcivictheatre.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: request region in the wrong spot?
References: <398DD9BB.30521791@rochcivictheatre.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Gall wrote:
>   I propose moving this 6 request region calls to
>
>   arch/ppc/kernel/setup.c in ppc_init()
>
>   which is called by init/main do_basic_setup() fairly early.
>
>   Is this a reasonable fix?

Generally pre-kmalloc request_region calls should occur in the form of
static struct resource variables being passed to __request_region.

	Jeff




--
Jeff Garzik              |
Building 1024            | Yossarian lives.
MandrakeSoft, Inc.       |

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
