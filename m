Date: Tue, 15 Jul 2003 10:58:19 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Steve Boorman <steveb@baydel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hangup booting Linux on PPC440GP
Message-ID: <20030715155819.GA26700@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <3F13FA14.16183.5C9485B@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F13FA14.16183.5C9485B@localhost>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 15, 2003 at 12:56:52PM +0100, Steve Boorman wrote:
> 3) I expected the kernel to panic with some form of illegal
> instruction trap if floating point instructions were being
> attempted with no emulator code present.

That's exactly what it's doing if you look into it with a debugger.
It'll be hung up with in an exception handler IIRC.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
