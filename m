Date: Sat, 10 Aug 2002 18:45:28 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michel D?nzer <michel@daenzer.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Weird interrupt problem
Message-ID: <20020810084528.GA5338@krispykreme>
References: <1028761518.1262.1236.camel@tibook> <20020808120700.30639@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020808120700.30639@192.168.4.1>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> It may be some kind of race within the openpic driver when we keep
> enabling/disabling the source in ack() and end(). I'm pretty sure
> we don't really need them, oh well...

Yeah I pulled that out of the ppc64 tree and I havent found a problem
yet. Maybe there was some buggy ppc32 hardware that required this?

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
