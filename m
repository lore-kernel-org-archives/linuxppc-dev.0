From: benh@kernel.crashing.org
To: Anton Blanchard <anton@samba.org>,
	Werner Almesberger <wa@almesberger.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: performance monitor exceptions
Date: Wed, 13 Feb 2002 13:48:11 +0100
Message-Id: <20020213124811.28885@mailhost.mipsys.com>
In-Reply-To: <20020213111450.GF3886@krispykreme>
References: <20020213111450.GF3886@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Thats rather ugly :( BTW I have run kernel profiling off the performance
>monitor exception on ppc64 which has been very useful (it allowed us
>to profile inside interrupt disabled regions)

A workaround for pmac or openpic ppc32 is to use the keylargo or the
openpic timer instead of the DEC. That could be a "kernel hacking" option

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
