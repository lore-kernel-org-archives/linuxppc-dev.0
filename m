Date: Mon, 24 Apr 2000 11:33:52 -0400 (EDT)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: Valéry Raulet <Valery.Raulet@enib.fr>
cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Boot failed with new 2.3.99 kernel !
In-Reply-To: <3904673C.2FF192C5@enib.fr>
Message-ID: <Pine.LNX.4.21.0004241130250.30736-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

> Call backtrace:
> 00000000 C01850DC C017FA88 C0195868 C017E7A8 C00039FC C0008E30
> Kernel panic: kernel access of bad area pc c0184da8 lr c01850dc address

Read Documentation/oops-tracing.txt, compile ksymoops and feed it this
junk. You'll get a pretty-looking backtrace that may explain a lot.
This will be an excellent starting point for further hacking.

Regards,
Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
