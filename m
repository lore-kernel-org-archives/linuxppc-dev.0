Date: Tue, 30 Oct 2001 13:32:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Boutcher <boutcher@us.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: current linuxppc_2_4_devel SMP strangeness.. (processes dieing)
Message-ID: <20011030133238.F13925@cpe-24-221-152-185.az.sprintbbd.net>
References: <OF89A2837B.F5221EF4-ON86256AF5.00703EC4@rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF89A2837B.F5221EF4-ON86256AF5.00703EC4@rchland.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 30, 2001 at 02:28:40PM -0600, David Boutcher wrote:
> > It's pre5 ? I think Tom's fix is wrong. It should probably be
> > copy_user_page or copy_cow_page (I use the last one). Without that,
> > the cache avoidance will probably win a direct ticket to hell ;)
>
> Changing the fix to copy_cow_page fixed the problem...so I pushed that
> change into the devel tree.  Hopefully Tom doesn't mind.

Not at all.  I just heard Paul say copy_highpage was gone in _devel and
something about copy_mem_page. :)  I need to go and get my breakable
PPCs up and running again....

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
