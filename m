From: benh@kernel.crashing.org
To: <mlan@cpu.lu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: crash on sleep with 2.4.19-pre4-ben0
Date: Thu, 28 Mar 2002 15:14:38 +0100
Message-Id: <20020328141439.20362@mailhost.mipsys.com>
In-Reply-To: <E16qa5v-0000NT-00@piglet.grunz.lu>
References: <E16qa5v-0000NT-00@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>How? The keyboard doesn't work under xmon.... I need to power-cycle.

You can try manually adding a call to backtrace() in xmon entry point

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
