Date: Mon, 2 Feb 2004 16:04:52 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Jean-Jacques Levy <Jean-Jacques.Levy@inria.fr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: m3mirror + 2.4.24
In-Reply-To: <200402021621.RAA01281@macaron.inria.fr>
Message-ID: <Pine.LNX.4.44.0402021603440.6279-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>    m3mirror crt:1 lcd:1
>
> which no longer works properly. The command runs silently with no

The kernel ioctls for m3mirror might have changed; recompile m3mirror
against new kernel headers?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
