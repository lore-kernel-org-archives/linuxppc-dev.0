Date: Tue, 29 Jan 2002 19:22:53 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200201300322.g0U3Mr400172@dave.home>
To: Josh_Horvath-AJH051@email.mot.com
Subject: Re: BUG: udp socket, getsockopt + setsockopt
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


That's not getting set anywhere, the socket code is really small, just
like a textbook example. The man page says that is read only...

-Dave

>This is just a guess, but is SO_RCVLOWAT getting set somewhere?  The receive
>call will block until it gets the number of bytes set with this option.  I
>think it defaults to 1, so it should normally return when any data is
>available on the socket.  But if it has been bumped up to a big number, it
>might account for the behavior you're seeing.
>
>-Josh

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
