Date: Thu, 13 Mar 2003 17:06:20 -0500
From: Kent Borg <kentborg@borg.org>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hardcoded Hash_base?
Message-ID: <20030313170620.P3222@borg.org>
References: <2702075D4DE2B043BF5EB82E9CFAD45B093BD8@mail1.mediatrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2702075D4DE2B043BF5EB82E9CFAD45B093BD8@mail1.mediatrix.com>; from jdboyer@mediatrix.com on Thu, Mar 13, 2003 at 12:44:50PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 13, 2003 at 12:44:50PM -0500, Jean-Denis Boyer wrote:
>
> > In arch/ppc/mm/hashtable.S Hash_base is hardcoded at 0xc0180000, with
> > a comment suggesting that that value is "just an example".  It seems
> > to be colliding with my initrd, so I am thinking I want to move it.
>
> As the comment says, this code is patched at runtime.
> It is done by MMU_init_hw, in arch/ppc/mm/ppc_mmu.c.
> The value of Hash_base could be anything, it doesn't matter.

I guess it does say that.  I my eyes glazed over the several times I
tried to understand the comment right before that.

Thanks,

-kb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
