Date: Thu, 6 Sep 2001 08:23:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Brian Waite <bwaite@cspi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MVME5100 and bugboot fails
Message-ID: <20010906082338.E21172@cpe-24-221-152-185.az.sprintbbd.net>
References: <200109061503.LAA11727@orchid.cspi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200109061503.LAA11727@orchid.cspi.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 06, 2001 at 10:55:46AM -0400, Brian Waite wrote:

> I am playing with the MVME5100 and I am having a bit of trouble with booting
> using bugboot and an initrd. I get a message at bootup saying initrd > 16 MB
> and then as it is booting it gets an oops in mem_init.
[snip]
> My question is is the failure due to the bootloader not relocating the initrd
> or is it that ClearPageReserved() is being called when the initrd is in
> FLASH? Any ideas?

Right now, we only see if we need to relocate the initrd if we need to relocate
the kernel.  I'll go and fix this (I think gemini has the right idea).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
