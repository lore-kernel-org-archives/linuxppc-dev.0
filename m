Date: Thu, 6 Sep 2001 08:56:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Brian Waite <bwaite@cspi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MVME5100 and bugboot fails
Message-ID: <20010906085639.F21172@cpe-24-221-152-185.az.sprintbbd.net>
References: <85256ABF.00549667.00@pine.cspi.com> <200109061544.LAA11977@orchid.cspi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200109061544.LAA11977@orchid.cspi.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 06, 2001 at 11:36:39AM -0400, Brian Waite wrote:

> I tried that and I was unable to relocate just the initrd. Right now, I just
> tested to see:
> if  ((zImage_start >= 0xf0000000) || (zImage_start <= 0x00800000))
>
> That seems to work for now, but I'll take a peek at the gemeni and see how
> they do it.

Er, after re-reading, it's wrong too.  I'll send you a patch
privately, if you can test it.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
