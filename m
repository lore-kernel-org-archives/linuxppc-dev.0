Message-ID: <20040427155249.37333.qmail@web41510.mail.yahoo.com>
Date: Tue, 27 Apr 2004 08:52:49 -0700 (PDT)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: Re: High resolution timer in driver 
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040426180654.5C035C109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I understood. It will help.

thanx a lot.

Bhupi

--- Wolfgang Denk <wd@denx.de> wrote:
> In message <20040426164104.21828.qmail@web41503.mail.yahoo.com> you wrote:
>
> > I am writting a device driver. I have a requirement that i need a
> > timer base interrupt serive routine which shall be called 1024 times
> > in a second. But my
>
> Find an unused timer on your processor, install an interrupt handler
> for it, and finally programm it in periodic mode with f=1024 Hz.
>
> Where is the problem?
>
> > understanding is saying that i can call it only once in a second
> > through generic linux timer.
>
> This is definitely wrong. Wrong twice, at least.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
