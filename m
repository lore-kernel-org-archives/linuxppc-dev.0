From: benh@kernel.crashing.org
To: Jeff Walther <trag@io.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 9600 maturity?
Date: Mon, 15 Apr 2002 06:01:03 +0100
Message-Id: <20020415050103.6412@mailhost.mipsys.com>
In-Reply-To: <a04310102b8e086debdbe@[199.170.89.178]>
References: <a04310102b8e086debdbe@[199.170.89.178]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I have found that any PCI card which has its own PPB hangs the
>machine (with a few exceptions) in the lower four slots.  i.e. if you
>create a hierarchy of two PPBs Apple's PCI implementation bails.
>
>Jeff Walther

Yes, this is a known bug of older OFs, though an OF patch is floating
around to fix it (dunno how to find it though).

Note that recent 2.4 kernels may be able to work around OF bugs here.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
