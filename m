To: Dan Malek <dan@embeddededge.com>
Cc: Jeremy Bowen <Jeremy.Bowen@opennw.com>,
	"'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems with MMU: address translation for 0xXXXXXXXX failed 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 13 May 2003 01:07:38 EDT."
             <3EC07D9A.6050604@embeddededge.com>
Date: Tue, 13 May 2003 10:08:01 +0200
Message-Id: <20030513080806.85B40C6092@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3EC07D9A.6050604@embeddededge.com> you wrote:
>
> If that doesn't work, just out of curiosity use hard breakpoints (set
> BREAKMODE HARD).  Just test it setting one breakpoint.  If this works,
> I suspect the BDI is honoring the write protection (via the MMU) on the
> kernel text pages and we can't set a soft breakpoint.  In this case, we'll
> have to add a kernel configuration to allow a debugger write.  The
> CONFIG_KGDB and CONFIG_XMON enable the text writing, but they also add
> too much baggage and could interfere with the BDI.  It's another thing

It should be sufficient to enable  CONFIG_BDI_SWITCH  in  the  kernel
configuration (after enabling CONFIG_DEBUG_KERNEL).


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If it happens once, it's a bug.
If it happens twice, it's a feature.
If it happens more than twice, it's a design philosophy.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
