Message-ID: <3C33890F.E89E4D3F@mvista.com>
Date: Wed, 02 Jan 2002 15:26:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: mod+linuxppc-dev@MissionCriticalLinux.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Changes to gt64260 interrupt support code
References: <200112271744.MAA03341@missioncriticallinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


mod+linuxppc-dev@MissionCriticalLinux.com wrote:

> Please introduce these changes into the linuxppc
> sources in order that the existing gt64260 interrupt
> support code be usable on platforms other than the
> Galileo Eval Board.

Michael,

I'm pushing your patch as I write this.  I made one change, though.
I changed the variable name gt64260_firstIRQ to gt64260_irq_base since it
seems more descriptive--firstIRQ makes me think of a special case for the
very first intr to happen.

You will need to make the appropriate changes to your internal code.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
