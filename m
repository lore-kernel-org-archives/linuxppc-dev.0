To: James Don <JDon@spacebridge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SELF: ramdisk which required libraries if ...? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 11 Jan 2003 15:31:21 EST."
             <DB0585C9F6F9D411BE8F00D0B7896A4CC06030@SNCMAIL>
Date: Sat, 11 Jan 2003 22:03:21 +0100
Message-Id: <20030111210326.A6FE0C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jim,

in message <DB0585C9F6F9D411BE8F00D0B7896A4CC06030@SNCMAIL> you wrote:
>
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 48k init
> Warning: unable to open an initial console
> <board hangs here>

Are you sure there is a proper /dev/ directory (especially
/dev/console) in your ramdisk image?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Just go with the flow control, roll with the crunches, and, when  you
get a prompt, type like hell.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
