Date: Tue, 28 Sep 1999 13:34:18 -0700 (PDT)
From: Deirdre Saoirse <deirdre@linuxcare.com>
To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.13 build OOB?; need for some standardization here?
In-Reply-To: <199909281522.KAA04793@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.10.9909281327440.2351-100000@gentoo.linuxcare.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 28 Sep 1999, Kevin_Hendricks wrote:

> Isn't there any way to do more standardization among the different powerpc linux 
> distributions (I know you want to differentiate your product to compete but..)
> 
> Right now, we have Debian ppc, Linux PPC, YellowDog Linux, TurboLinux,
> MkLinux DR1, etc all vying for the same user base.

MkLinux and LinuxPPC are effectively identical except for kernel. The
file hierarchy is the same (Red Hat based).

Furthermore, SuSE has announced that it too will be interested in a
PowerPC port. There's a LOT of interest in PowerPC these days.

> This is literally a nightmare for tracking down bug reports of keycode problems 
> in the jdk, video driver problems, etc.

It is said that on the x86 kernel,  almost 50% of reported kernel bugs are
people running vmware.

> To more unify this, should we have our own clone of Alan Cox to make 
> "semi-official" updates to the "official" stable tree to make things more 
> official for ppc.  
> 
> Is this a role for Paul?  (it is the role that Paul has filled for a very long 
> time now, maybe it should be "official").  If so, then publize that being the 
> one "true" source for "official" ppc kernel trees.

I thought this already WAS Paul Mackerras.

> Am I simply worrying too much?

Yes. :)

-- 
Deirdre Saoirse, Systems Analyst, Linuxcare, Inc.
415.354.4878 x252 tel, 415.701.7457 fax
dsaoirse@linuxcare.com, http://www.linuxcare.com/
Linuxcare. At the center of Linux.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
