Message-ID: <3C97C1EE.60D106FA@mvista.com>
Date: Tue, 19 Mar 2002 17:55:42 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org, mporter@mvista.com,
	linux-galileo@source.mvista.com
Subject: Re: [PATCH] My GT-64260 enhancements
References: <0203200046.AA08257@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:

> OK, guys, here again is my patch to bi_rec'ize the EV-64260-BP port, the common
> GT-64260 code, and the GT-64260 Ethernet driver in linuxppc_2_4_devel (against
> 2_4_devel because it adds two new bi_recs to the master official bi_rec list in
> bootinfo.h) with all controversial parts removed, just the bi_rec'ization.
>
> I ask Matt Porter, the maintainer listed in linuxppc_2_4_devel/MAINTAINERS to
> either push this patch into linuxppc_2_4_devel or give a good reason not to.

No, Matt is not the maintainer for any of the 64260 code.  If anyone is, it would be me (or Troy) and I will
resist pushing such a patch until there is agreement on what the set of bi_recs will be and there is a patch
that implements *all* of them.  However, if there is no agreement in the next few days, I will push it since it
is a step in the right direction.

If enough people object to my position then I will apply it.  Alternatively, if you can convince someone else
to push it for you, more power to you.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
