Date: Thu, 18 Sep 2003 10:26:40 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Todd <to_dd@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: fundamental driver question ??
Message-ID: <20030918102640.A9176@home.com>
References: <20030918171414.49505.qmail@web40413.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030918171414.49505.qmail@web40413.mail.yahoo.com>; from to_dd@yahoo.com on Thu, Sep 18, 2003 at 10:14:14AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 18, 2003 at 10:14:14AM -0700, Todd wrote:
>
> When a module is driving multiple devices: does the
> driver code itself have multiple instances, or is
> there a single instance of the code which is
> re-entrant??

reentrant

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
