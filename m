Date: Tue, 7 Jan 2003 11:57:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: paulus@samba.org, devel list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: get_pteptr prototype
Message-ID: <20030107005751.GP22215@zax.zax>
References: <1041893967.1207.42.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1041893967.1207.42.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 06, 2003 at 04:59:26PM -0600, Hollis Blanchard wrote:
> Hi, I think the prototype for get_pteptr should be moved to
> asm/pgtable.h . It currently is declared extern in mm/fault.c, and I
> will need it for platforms/ibm405lp_pm.c .
>
> Please apply to _2_4_devel and -2.5, and probably _2_4 for that matter.

Hrm... what are you actually intending to use get_pteptr() for.  There
are currently only two users, one of which needs to die (in 2.5, at
least).  My experience has been that the concept of get_pteptr() is a
great deal less useful that one would, at first, think.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
