Subject: Re: help with asm code?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <40867E82.3010202@nortelnetworks.com>
References: <4085483B.1090604@nortelnetworks.com>
	 <1082506664.2077.9.camel@gaston>  <40867E82.3010202@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1082588543.2077.86.camel@gaston>
Mime-Version: 1.0
Date: Thu, 22 Apr 2004 09:02:23 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The code is being called from fast_exception_return, syscall_exit_cont,
> and restore_user.
>
> > How do you know it dies there and not elsewhere ?
>
> If I remove the lbzx/add lines, everything works fine.  With the lbzx
> line it dies, even if r10 is overwritten right away.

You'd have to send me the whole exception code path so I can figure
out what's up

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
