Date: Mon, 2 Jun 2003 09:53:03 -0500
Subject: Re: Kernel Panic in 2.2.x
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev@lists.linuxppc.org
To: linas@linas.org (Linas Vepstas)
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <20030531005832.GA4272@backlot.linas.org>
Message-Id: <E985F997-9509-11D7-BBCD-000A95A0560C@us.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday, May 30, 2003, at 19:58 US/Central, Linas Vepstas wrote:
>
> Linux is real strong in the server space, weak in the desktop.  Server
> 'users' are almost exclusively sysadmins.  They run systems for 5 years
> or more.  (my www.linas.org is an 9 year old Dell 486.  www.gnucash.org
> is 3.5 years old)  When a server goes down, hundreds of users are
> affected.  (each of the www.gnucash.org mailing lists have 500+
> subscribers, I move 7-10 GBytes a month.).  I think we need to make
> sure
> that Linux in the server space benefits the sysadmin, and this means
> very conservative design principles, and conservative installers
> (something that really can backout the new version and replace old
> version).   God help us all if one day Microsoft succeeds in building
> a system that is easier to install/upgrade/manage than a Linux server.
> Don't bite the hand that is currently feeding Linux.

There's no problem here. Keep right on installing <distribution from
1996> until your hardware dies, and it won't bother me one bit.
Backport security fixes (or find others who have already), and ignore
reports about the latest wonderful features in the current version.
Your 500+ subscribers will thank you.

However, don't complain that upgrading your system can make things
break and ask me for sympathy. :) I for one would rather spend my time
making things work than making things backwards-compatible back to
version 0.3. I guess you're trying to convince me of the exact
opposite, but IMHO there's simply too much stuff left to get working.
Once it all works then we can talk about backwards-compatibility... ;)

--
Hollis Blanchard
IBM Linux Technology Center

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
