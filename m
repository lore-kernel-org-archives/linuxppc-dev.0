Date: Wed, 28 Apr 1999 08:27:10 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Satadru Pramanik <satadru@umich.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Rel 5 ssh?
In-Reply-To: <Pine.LNX.4.10.9904280104180.19702-100000@beer.pub.umich.edu>
Message-ID: <Pine.SUN.4.02.9904280825510.16076-100000@sea.ntplx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


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


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
