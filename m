Date: Wed, 2 Jan 2002 12:30:46 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: mod+linuxppc-dev@MissionCriticalLinux.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Changes to gt64260 interrupt support code
Message-ID: <20020102123046.U25200@altus.drgw.net>
References: <200112271744.MAA03341@missioncriticallinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200112271744.MAA03341@missioncriticallinux.com>; from mod+linuxppc-dev@MissionCriticalLinux.com on Thu, Dec 27, 2001 at 12:44:24PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Dec 27, 2001 at 12:44:24PM -0500, mod+linuxppc-dev@MissionCriticalLinux.com wrote:
>
>
> Please introduce these changes into the linuxppc
> sources in order that the existing gt64260 interrupt
> support code be usable on platforms other than the
> Galileo Eval Board.
>
> The current gt64260 interrupt support code forces
> use of particular Linux irqs (starting from 0) for
> particular GT64260 interrupt sources.  These changes
> allow use of that support code in other platforms and
> (of particular interest in my situation) in combination
> with other interrupt controllers (like the elegant
> and flexible 8259) that also want to map *their*
> interrupt sources to the Linux irqs starting at 0...

Ugh. Did I mention I hate 8259's?

We **REALLY** need a better way to deal with cascaded 8259's than adding
an offset.. I think Dan Malek had some good ideas on what to do about
this, but I don't know that anyone has got any currently running code that
solves this problem nicely.



--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
