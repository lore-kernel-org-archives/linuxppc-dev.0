Date: Sat, 4 Aug 2001 16:37:50 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Versioned module symbols broken for PPC?
Message-ID: <20010804163750.A735@ibrium.se>
References: <20010804153849.A2056@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010804153849.A2056@ibrium.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 04, 2001 at 03:38:49PM +0200, Samuel Rydh wrote:
>
> The support for versioned symbols seems to be broken.
> After a mrproper recompile, /proc/ksyms contains entries
> like
>
> 	c0148940 nf_hook_slow_R__ver_nf_hook_slow
>
> which obviously is wrong. (This is with Ben's tree,
> but I've seen it in the BK tree too. I think
> this problem appeared in 2.4.5-something).
>

At a closer investigation it appears the distribution I'm currently
using has a broken modutils package (/sbin/genksym is missing).

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 790nnnn
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
