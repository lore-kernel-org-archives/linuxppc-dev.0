Date: Mon, 13 Jan 2003 11:48:55 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Mark Chambers <markc@mail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Control-C in bash ???
Message-ID: <20030113194855.GA16266@f00f.org>
References: <200301131409.00113.markc@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200301131409.00113.markc@mail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jan 13, 2003 at 02:09:00PM -0500, Mark Chambers wrote:

> On a PC, I can, for instance, enter "ping 192.168.1.4", then hit
> Control-C and stop the ping.  For the life of me, I can't figure out
> how to do the same on my MPC860 system!!!

if you boot init=/bin/sh or whatever and your init/login doesn't set
the tty up, you will need to do it yourself (man stty).


  --cw

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
