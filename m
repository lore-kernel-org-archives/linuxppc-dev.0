Date: Thu, 3 Jan 2002 22:03:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Brian Kuschak <brian.kuschak@skystream.com>
Cc: "'Jerry Van Baren'" <vanbaren_gerald@si.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Corrupted ramdisk image
Message-ID: <20020104050313.GI749@cpe-24-221-152-185.az.sprintbbd.net>
References: <B25E2E5A003CD311B61E00902778AF2A02BBDAA7@SERVER1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B25E2E5A003CD311B61E00902778AF2A02BBDAA7@SERVER1>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jan 03, 2002 at 03:21:18PM -0800, Brian Kuschak wrote:

> Changing the mktree.c file to put the entry point at 0x400000 instead of
> 0x500000 fixes the problem for me.

mktree takes an argument (last one, iirc) of an optional entry point.
The IBM Spruce platform takes advantage of this.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
