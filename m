To: llandre <r&d@wawnet.biz>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Silicon Motion VGA controllers and PPC architecture 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 12 Nov 2003 17:52:28 +0100."
             <5.1.1.6.0.20031112173538.01bd2e78@dns.struinfo.it>
Date: Wed, 12 Nov 2003 20:36:48 +0100
Message-Id: <20031112193653.27D38C5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5.1.1.6.0.20031112173538.01bd2e78@dns.struinfo.it> you wrote:
>
> I'm looking for a VGA controller to use with an embedded PPC405-based system.
> I had a look at the Silicon Motion chips (712/722) and they seem very
> suited for embedded applications.
> Unfortunately the techical support claims that these chips, because the
> presence of x86 BIOS, support only the x86 architecture. Anybody can
> confirm this?

The presence of a x86 BIOS is no killing point to use such a board on
a PowerPC system. All you need to do is to run the BIUOS  code  using
some  sort  of x86 emulator. Such a beast is for example available in
U-Boot - the AmigaOneG3SE board uses it.

Ummm.. I didn't say it was trivial to get this running,  but  it  has
been done before.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Where would we be without rhetorical questions?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
