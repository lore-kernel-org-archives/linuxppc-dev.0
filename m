In-Reply-To: <8525685E.0056E2AE.00@D51MTA03.pok.ibm.com>
Date: Thu, 6 Jan 2000 17:19:19 +0100
To: jlquinn@us.ibm.com, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Building 2.3.35?
Message-Id: <20000106171919.015242@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 6, 2000,  <jlquinn@us.ibm.com> wrote:


>2.3.35 is the first unstable kernel that I've put some effort in getting to
>build.  I only get to play with stuff for 2-3 hours a week, so it's hard to
>really do debugging at the rate of kernel development :-)
>
>How does merging of the vger tree into Linus' development kernel work right
>now?

The main ppc tree, for now, is not vger but Cort's bitkeeper. (I don't
know if Cort keeps vger updated).

2.2.x is fully in sync with Linus (except for the USB backport, but
that's normal).
2.3.x changes are, I think, sent to linus regulary, but there is still
some work needed to get the latest 2.3.35/36 kernels to work on powermac.
Hopefully Cort, Paul and I (and probably others are working on this).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
