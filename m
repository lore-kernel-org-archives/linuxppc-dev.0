Date: Fri, 19 Oct 2001 14:28:59 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Paul Mackerras <paulus@samba.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: arch/ppc/kernel clutter
In-Reply-To: <15312.6740.808012.183783@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0110191426580.27649-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I feel that arch/ppc/kernel in the linuxppc_2_4_devel tree is getting
> more than a bit cluttered.  I propose that we make a new
> arch/ppc/platforms directory and move the platform-specific files into
> there - i.e. all of *_setup.c, *_pic.c, *_pci.c, and maybe some

I was wondering how you guys could live with that situation anyway. Why
not have arch/ppc/powermac/, arch/ppc/prep/, arch/ppc/chrp/ and more of
the same?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
