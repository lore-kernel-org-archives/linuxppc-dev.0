Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC06032@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'Wolfgang Denk'" <wd@denx.de>, James Don <JDon@spacebridge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: SELF: ramdisk which required libraries if ...? 
Date: Sat, 11 Jan 2003 19:57:50 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes your right ... thnx ;-)

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Saturday, January 11, 2003 4:03 PM
To: James Don
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: SELF: ramdisk which required libraries if ...?

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
