Date: Fri, 4 Apr 2003 22:09:36 -0800
From: Chris Zimman <chris@cryptoapps.com>
To: Jerry Walden <jwalden123@adelphia.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: custom PPC405GPr board almost boots - one last step
Message-ID: <20030405060936.GA28528@mail.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <MMEKKOMGOBGEIENHLGDLMEJGCHAA.jwalden123@adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MMEKKOMGOBGEIENHLGDLMEJGCHAA.jwalden123@adelphia.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Apr 04, 2003 at 11:24:16PM -0500, Jerry Walden wrote:
> Well I'm getting much further now.  Problem was I did not have ext2
> filesystem in
> my kernel configuration.  Now the initialization seems to complete and it
> looks to
> me like either a prompt is trying to print out, or some other type of text.
> In any
> case I am wonder when the boot gets as far as this one does, can or does
> something
> happen to the serial port?  Does it try to bring up a console on the serial
> port
> and somehow is getting confused?
> .?
> 9H?.6??.??).?)!).!)!?..??..???9.???.?).????.??...?1.??1?9?.6?..)!?..!!.)...?
> 3H????.?...!)!.&?...?!?

Check the baud rate of ttyS0 in /etc/inittab

If you are booting with 9600, then you need to have
something like:

# Example how to put a getty on a serial line (for a terminal)
#
T0:23:respawn:/sbin/getty -L ttyS0 9600 vt100

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
