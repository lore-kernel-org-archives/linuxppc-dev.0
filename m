Date: Thu, 5 Jul 2001 18:55:58 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: David Edelsohn <dje@watson.ibm.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __divdi3 unresolved + X pointer blocks 
In-Reply-To: <200107051529.LAA29124@makai.watson.ibm.com>
Message-ID: <Pine.LNX.4.33.0107051849390.2824-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 	The two suggestions of writing the divide as a shift and linking
> with libgcc.a BOTH ARE WRONG.

I haven't seen anyone suggest we link the kernel with libgcc.a. Just 'the
kernel needs to provide __divdi3'. As in: the kernel needs to provide a
hell of a lot of libgcc.a stuff on the various architectures (ashldi3,
ashrdi3, lshrdi3 come to mind, m68k and sparc). It's been done for ages.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
