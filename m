Date: Mon, 14 Jul 2003 12:38:38 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Steve Boorman <steveb@baydel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hangup booting Linux on PPC440GP
Message-ID: <20030714173838.GA23068@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <3F12E900.23193.19E927F@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F12E900.23193.19E927F@localhost>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 14, 2003 at 05:31:44PM +0100, Steve Boorman wrote:
> machine hangs up, no panic or anything else displayed on the console. If I
> remove /sbin/init then I do get the obvious panic, "No init found.  Try
> passing init= option to kernel."
>
> I tried replacing /sbin/init with a static linked program which just does a
> printf of "hello world", this hangs in the same way with no message. This
> prog was compiled using the Starmax running Yellow Dog V3, kernel
> 2.4.20-8D / gcc 3.2.2.

Do you have math emulation compiled into the kernel?

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
