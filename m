Date: Thu, 4 Jan 2001 18:36:44 -0800
From: David Schleef <ds@schleef.org>
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux boot fails after MMU (MPC8260)
Message-ID: <20010104183644.A20037@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
References: <0G6N00K6Y4ZYFB@pmdf-it.hasler.ascom.ch> <3A54BFCF.8EC56F45@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A54BFCF.8EC56F45@mvista.com>; from dan@mvista.com on Thu, Jan 04, 2001 at 01:24:15PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jan 04, 2001 at 01:24:15PM -0500, Dan Malek wrote:
>
> For now, the only working version of Linux on the 8260 is from
> the MontaVista web site.  It is a -test2 version.

Don't be so pessimistic... =)  I've been running the bitkeeper
kernel on an 8260 for several months now, synchronizing every
few weeks.  Works fine, except for the occasional bug hunt.


> If you have
> access to the FSM Labs BitKeeper sources, I will be updating these
> for the 8260 before the end of the week.

I have an ever-increasing patch that I should probably clean
up and send to you, but I keep putting it off.  Even in its
current hackish form, it should be useful for bug hunting.
Let me know.





dave...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
