Date: Wed, 7 Apr 2004 17:04:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: System ACE MPU interface to CF card
Message-ID: <20040408000440.GP31152@smtp.west.cox.net>
References: <407470ED.3030607@buckeye.ece.drexel.edu> <6058-40021@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6058-40021@sneakemail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 07, 2004 at 04:09:33PM -0700, Stephen Williams wrote:
>
> Sharad Gupta sharad-at-buckeye.ece.drexel.edu |PPC Linux Embedded| wrote:
> >
> >Hi All,
> >
> >I would like to know if anyone in the group or otherwise is/was using
> >Xilinx's System ACE MPU interface to read/write to Compact Flash card on
> >their hardware ? I see that there is a device driver provided by Xilinx
> >for system ace mpu bus in the linux kernel tree (2.4.23). But, I dont
> >see anyone actually implementing it in their design.
>
> That would be me. I haven't yet submitted patches for my JSE
> board, but if you look back to the last few weeks in this list,
> you'll see plenty of messages with SystemACE in their subject.
>
> Including a patch on 1 April 2004 to generalize the driver a
> bit. MonteVista folks have approved the patch, so I hope it
> turns up inofficial trees in due course.

The previous message reminded me that I still hadn't pushed that patch,
so I did that a few hours ago (and it should show up on the commit list
in due course).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
