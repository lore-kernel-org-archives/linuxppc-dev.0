To: Tom Rini <trini@kernel.crashing.org>
Cc: Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 12 Nov 2003 08:18:24 MST."
             <20031112151824.GC31581@ip68-0-152-218.tc.ph.cox.net>
Date: Sun, 16 Nov 2003 21:33:13 +0100
Message-Id: <20031116203318.21D9CC5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Tom & Dale,

in message <20031112151824.GC31581@ip68-0-152-218.tc.ph.cox.net> you wrote:
>
> Can I suggest breaking the trend slightly based on comments people have
> made about 2.5/2.6?  Let's call it CONFIG_PPC_5xxx (and someday fix all
> of the others).

OK, so the discussion has stopped. What's happening now? I  sent  our
stuff.  Dale  has  added some modification. We have more works in the
queue. I think it makes little sense to  continue  without  a  common
code base.

Can you give any estimates when something will go into a public tree,
and what this will be, and which tree?

If there is any reason for you not to use the  "common"  trees  (like
linuxppc_2_4_devel  ?)  yet,  maybe  we  can at least put the current
state into a more dedicated tree like
bk://source.mvista.com/linuxppc_2_4_mgt5100

So that we can at least avoid to duplicate efforts while the work  is
going on?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
panic: kernel trap (ignored)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
