To: jwalden@digitalatlantic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using BDI-2000 to debug kernel 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 13 Mar 2003 17:23:40 EST."
             <EGEGIJHKDKJGAJMGIDPNEEEGCJAA.jwalden@digitalatlantic.com>
Date: Fri, 14 Mar 2003 00:26:37 +0100
Message-Id: <20030313232642.C1BA6C58BB@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <EGEGIJHKDKJGAJMGIDPNEEEGCJAA.jwalden@digitalatlantic.com> you wrote:
> I'm using an app note that came with the
> BDI-2000.  The app note is Number 02-001.

I guess you are referring to a document creadted and provided by USI,
right?

> Unless the app note is completely wrong then I am missing something.

It is not completely wrong, but makes certain assumptions, which  are
mentioned, but probably you overlooked this. The document describes a
system  which  uses  a proprietary boot loader, which does not load a
plain Linux kernel, but a "zImage"  file.  This  includes  a  special
"bootstrap loader" as code, and the Linux kernel image as payload. It
is  this  bootstrap loader which is relocatable to an arbitrary start
address.

> The steps I take depicted below are exactly the same as in the
> app note.

No, you are mistaken. You tried to start a plain Linux  kernel.  This
does not work that way.


Note also that their description of module debugging is missing  some
parts that may be necessary for full operation.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Suffocating together ... would create heroic camaraderie.
	-- Khan Noonian Singh, "Space Seed", stardate 3142.8

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
