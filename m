Date: Wed, 2 Jun 1999 08:53:02 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Brad Midgley <brad@turbolinux.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rsync kernel compile fails
In-Reply-To: <Pine.LNX.3.95.990602005536.28345A-100000@pacific.pht.com>
Message-ID: <Pine.SUN.4.02.9906020851270.12257-100000@sea.ntplx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2 Jun 1999, Brad Midgley wrote:

> is the rsync kernel supposed to be working? i haven't changed my config
> but it fails to compile:

It looks like a bit of trouble merging the new USB stack and Inaky's in
the rsync tree.  I saw a message from Paul on the USB list asking which
OHCI driver to use (I think the 1st one offered at config time is the best
one, they'll be merged together soon anyways)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
