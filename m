Message-Id: <200201071915.OAA30811@missioncriticallinux.com>
To: linuxppc-embedded@lists.linuxppc.org
From: mod+linuxppc-embedded@MissionCriticalLinux.com
Subject: Re: How many Interrupts at the same time? 
In-Reply-To: Your message of "Mon, 07 Jan 2002 21:04:17 +0100."
             <3C39FF41.87AD961A@web.de>
Date: Mon, 07 Jan 2002 14:15:28 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>What options do we have?

do_IRQ() keeps asking your get_irq()
routine which irq to serice.  Couldn't your
get_irq() keep reporting pending requests
until all (currently known) requests were
satisfied?  It isn't necessary to actually
commence a nested instance of exception
handling for every request, right?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
