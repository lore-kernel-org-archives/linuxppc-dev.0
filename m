To: Jeremy Bowen <Jeremy.Bowen@opennw.com>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems with MMU: address translation for 0xXXXXXXXX failed 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 13 May 2003 16:19:26 +1200."
             <DEA23DB61B62D4118B5900508B323B84012CC7D1@OPENMAIL>
Date: Tue, 13 May 2003 09:55:18 +0200
Message-Id: <20030513075523.E8207C6092@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <DEA23DB61B62D4118B5900508B323B84012CC7D1@OPENMAIL> you wrote:
>
> I'm trying to get a BDI2000 (firmware v1.09) working in order to debug a
> kernel module.
> I'm using an Embedded Planet RPXlite MPC850 board running kernel v2.4.20
...
> Am I missing something obvious ? Is this the right way to go about debugging
> a loadable module ? Any help would be gratefully appreciated.

There were a couple of changes  /  extensions  to  the  MMU  support.
Firmware version 1.09 is pretty old (Aug 2001). You might want to try
a  more  recent one. Also check the changes to the Linux kernel - the
use of the PTBASE parameter has changed; the BDI2000 now expects (and
the Linux kernel automatically updates) the  physical  address  which
holds  the  virtual  address  of  the  array  with the two page table
pointers.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Status quo. Latin for "the mess we're in."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
