To: Prakash kanthi <pkanthi@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Flash File System 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 Mar 2003 23:01:31 PST."
             <20030326070131.88176.qmail@web41202.mail.yahoo.com>
Date: Wed, 26 Mar 2003 08:34:07 +0100
Message-Id: <20030326073412.21FAFC58BA@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030326070131.88176.qmail@web41202.mail.yahoo.com> you wrote:
>
> I have a 32MB Intel Strata flash on my PPC405 based
> custom board. I need to create access routines/APIs to
> access the flash. I was thinking of creating a Flash
> File System and mount it as a device in Linux
> environment.
>
> Are there any off the shelf FFS packages available?
> Generally, how the flash is used?

Use the MTD layer.

> I am working with micro-monitor to use its Tiny File
> System on flash support and eventually mount into
> linux. Did anyone use this combination before?

I think you cannot do this. AFAIK the TFS code is not available under
a GPL compatible license which prevents it from being linked with the
Linux kernel code.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There is is no reason for any individual to have a computer in  their
home.      -- Ken Olsen (President of Digital Equipment Corporation),
              Convention of the World Future Society, in Boston, 1977

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
