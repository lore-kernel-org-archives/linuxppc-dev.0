Date: Wed, 7 Aug 2002 08:12:35 -0700
From: Larry McVoy <lm@bitmover.com>
To: "David M?ller (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with bk repository?
Message-ID: <20020807081235.A25094@work.bitmover.com>
References: <3D4FEA26.1070403@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D4FEA26.1070403@elsoft.ch>; from d.mueller@elsoft.ch on Tue, Aug 06, 2002 at 05:24:22PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There was a corrupted PPC logging tree and I have fixed that.  I apologize
for any problems, we are working on trying to make this stuff work better.

On Tue, Aug 06, 2002 at 05:24:22PM +0200, "David M?ller (ELSOFT AG)" wrote:
>
> Hello
>
> In the last few days and weeks, i'm seeing in increasing number of
> errors like this:
>
> david@devil:/repository/linuxppc_2_4_devel>bk parent
> Parent repository is bk://ppc.bkbits.net/linuxppc_2_4_devel
> david@devil:/repository/linuxppc_2_4_devel>bk pull -ll
> ERROR-Can't get read lock on the repository.
> pull: remote locked, trying again...
> ERROR-Can't get read lock on the repository.
> pull: remote locked, trying again...
> ERROR-Can't get read lock on the repository.
> pull: remote locked, trying again...
> ERROR-Can't get read lock on the repository.
> pull: remote locked, trying again...
>
>
> Is this something to worry about or just some kind of "bandwidth
> limitation"?
>
>
> Dave
>
>

--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
