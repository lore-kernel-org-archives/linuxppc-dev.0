To: Tom Rini <trini@kernel.crashing.org>
Cc: Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Nov 2003 08:19:48 MST."
             <20031117151948.GB30251@ip68-0-152-218.tc.ph.cox.net>
Date: Mon, 17 Nov 2003 17:02:45 +0100
Message-Id: <20031117160250.CD994C5F59@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20031117151948.GB30251@ip68-0-152-218.tc.ph.cox.net> you wrote:
>
> > > Per your suggestion above, I created
> > > bk://source.mvista.com/linuxppc_2_4_mpc5200
> >
> > Which source tree / change set is this based on?
>
> It's semi-moot.  I've created a linux-2.4-mgt5100 tree, based off of

Can you please translate this into English for me?

My question was: is bk://source.mvista.com/linuxppc_2_4_mpc5200  base
on linuxppc_2_4 or linuxppc_2_4_devel, and which exact ChangeSet.

Why do you create a new tree ...-mgt5100 ? The MGT5100 can safely  be
considered  dead  (except that ther eare some systems out there which
remain being supported),.

> Marcelo's tree to carefully check things into, and hopefully get him to
> pull from in 2.4.24-pre time-frame.  I'll email everyone again once I've
> got it populated with stuff from Dale's tree.


Can you please explain the rationale behind  creating  a  new  source
tree?  There  is  the old bk://source.mvista.com/linuxppc_2_4_mgt5100
tree, there is now Dave's new  linuxppc_2_4_mpc5200  tree.  There  is
linux-2.4, linux-2.5, linuxppc_2_4_devel, linuxppc-2.4, linuxppc-2.5.
There  is  a  couple  other, less official source trees (like Ben's).
There is our CVS tree.

And instead of reducing the confusion about all the different  kernel
source trees you created yet another one?? Why?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It's like deja vu all over again."                      - Yogi Berra

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
