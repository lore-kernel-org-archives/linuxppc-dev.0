Message-ID: <20701.216.110.51.8.1081286606.squirrel@www.orkun.us>
In-Reply-To: <20040406211439.GD31152@smtp.west.cox.net>
References: <15133.216.110.51.8.1081278001.squirrel@www.orkun.us>
    <20040406200057.GB31152@smtp.west.cox.net>
    <19625.216.110.51.8.1081285199.squirrel@www.orkun.us>
    <20040406211439.GD31152@smtp.west.cox.net>
Date: Tue, 6 Apr 2004 16:23:26 -0500 (CDT)
Subject: Re: Question on RTC options (CONFIG_RTC, CONFIG_GEN_RTC,
      CONFIG_PPC_RTC)
From: "Tolunay Orkun" <listmember@orkun.us>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> GEN_RTC is a generic RTC driver, which offers hooks to the architectures
> to do the hw-specific portions.  This _could_ be made to work with RTCs
> over I2C, but at this time does not.

Can you offer some info/pointers regarding what do I need to implement to
get the generic driver work with my board?

> PPC_RTC is like the above, except it calls the PPC hooks directly, and
> is obsolete (and gone in 2.6).

These hooks are ppc_md.get_rtc_time and ppc_md.set_rtc_time right? I was
thinking of providing these functions in arc/ppc/platforms/csb272.c but if
this driver is obsolete, I would rather use the generic interface above.

Best regards,
Tolunay

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
