Subject: Re: current linuxppc_2_4_devel SMP strangeness.. (processes dieing)
To: <linuxppc-dev@lists.linuxppc.org>
Cc: <trini@kernel.crashing.org>
Message-ID: <OF89A2837B.F5221EF4-ON86256AF5.00703EC4@rchland.ibm.com>
From: "David Boutcher" <boutcher@us.ibm.com>
Date: Tue, 30 Oct 2001 14:28:40 -0600
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> It's pre5 ? I think Tom's fix is wrong. It should probably be
> copy_user_page or copy_cow_page (I use the last one). Without that,
> the cache avoidance will probably win a direct ticket to hell ;)

Changing the fix to copy_cow_page fixed the problem...so I pushed that
change into the devel tree.  Hopefully Tom doesn't mind.

Dave Boutcher
Senior Technical Staff Member
iSeries Linux Development and Architecture


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
