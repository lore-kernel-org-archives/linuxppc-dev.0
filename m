Date: Wed, 2 Jan 2002 17:23:17 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: mod+linuxppc-dev@MissionCriticalLinux.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Changes to gt64260 interrupt support code
Message-ID: <20020102172317.V25200@altus.drgw.net>
References: <200112271744.MAA03341@missioncriticallinux.com> <3C33890F.E89E4D3F@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C33890F.E89E4D3F@mvista.com>; from mgreer@mvista.com on Wed, Jan 02, 2002 at 03:26:23PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 02, 2002 at 03:26:23PM -0700, Mark A. Greer wrote:
>
> mod+linuxppc-dev@MissionCriticalLinux.com wrote:
>
> > Please introduce these changes into the linuxppc
> > sources in order that the existing gt64260 interrupt
> > support code be usable on platforms other than the
> > Galileo Eval Board.
>
> Michael,
>
> I'm pushing your patch as I write this.  I made one change, though.
> I changed the variable name gt64260_firstIRQ to gt64260_irq_base since it
> seems more descriptive--firstIRQ makes me think of a special case for the
> very first intr to happen.

err, if you're going to commit this, let's be consistent with openpic
and use 'gt64260_pic_irq_offset'....

(arch/ppc/kernel/open_pic_irq_offset)

Also see openpic_init() .... the offset is passed in


--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
