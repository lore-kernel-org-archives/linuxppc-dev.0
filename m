Date: Wed, 28 Apr 1999 13:51:18 -0400 (EDT)
From: Satadru Pramanik <satadru@umich.edu>
To: Tom Rini <tmrini@ntplx.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Rel 5 ssh?
In-Reply-To: <Pine.SUN.4.02.9904280825510.16076-100000@sea.ntplx.net>
Message-ID: <Pine.LNX.4.10.9904281350090.24995-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks a lot everybody.  ssh compiles cleanly now, and that hint on the
unix98 pty config was the key to getting sshd working right.  


On Wed, 28 Apr 1999, Tom Rini wrote:

On Wed, 28 Apr 1999, Satadru Pramanik wrote:

> login.c: In function `record_login':
> login.c:437: structure has no member named `ut_syslen'
> login.c:441: structure has no member named `e_termination'
> login.c:442: structure has no member named `e_exit'
> login.c:454: `WTMPX_FILE' undeclared (first use in this function)
> login.c:454: (Each undeclared identifier is reported only once
> login.c:454: for each function it appears in.)
> 
> Any thoughts?  Does anybody know how to fix this?  The sshd from this
> install can't allocate ptys either.

Delete the ut_syslen line.  e_term/e_exit->__e, WTMPX_FILE->_PATH_WTMP (i
think..).  As for the pty probllem, make sure you have a current dev rpm
and have Unix98 pty suport compiled in.

--
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


--=
satadru pramanik `satadru@umich.edu' www.umich.edu/~satadru
Online Editor, The Michigan Daily
Yugoslavia declares 'peace' in Kosovo; NATO Airstrikes
continue
-CNN Interactive, 04/08/99
=--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
