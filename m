Message-Id: <200010261927.e9QJRhj05217@denx.local.net>
To: Kyle Harris <kharris@nexus-tech.net>
cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDM recommendations 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 26 Oct 2000 13:38:53 EDT."
             <39F86C2D.C242473B@nexus-tech.net>
Date: Thu, 26 Oct 2000 21:27:43 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <39F86C2D.C242473B@nexus-tech.net> Kyle Harris wrote:
>
> I'm looking to purchase a new BDM emulator. Does anyone have
> suggestions. I've been using EST's for several years on the 68xxx

Since you're asking in a Linux group, it is probably  important  that
you  chose one that supports the MMU to allow Linux kernel and device
driver debugging.

At the moment I know of only one commercial product  that  integrates
well  in  a  Linux  environment:  that's  the BDI2000 by Abatron (see
www.abatron.ch). It provides boh a siple telnet interface  (which  is
useful  for  instance  for  image download or flash programming), and
also talks GDB remote protocol over the net, so you can attach easily
with GDB.

The other, non-commercial solution is MPCBDM or BDM4GDB as it's being
called today; see http://bdm4gdb.sourceforge.net/ .

Please let me know if you need more details.

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In the beginning, there was nothing, which exploded.
                                - Terry Pratchett, _Lords and Ladies_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
