To: Dan Malek <dan@mvista.com>, Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Wolfgang's updates 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Mar 2001 19:38:28 EST."
             <3A9EEB84.63C6412@mvista.com>
Date: Mon, 12 Mar 2001 22:57:52 +0100
Message-Id: <20010312215757.3804D281DB@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Dan, Tom,

in message <3A9EEB84.63C6412@mvista.com> you wrote:
>
> I finally got around to pushing some of Wolfgang's patches.
> There were lots of files touched outside of the PowerPC directories,
> that I simply can't update (like the flash and IDE stuff).  I

Thank you very much. That's a really big improvemnt for us.

Ummm... The flash stuff is just adding NEW files. The fact they  have
been tested on PPC only should not create a problem adding the files.
Many people add x86 drivers that don't work on PPC ;-)

Anyway.

I'm back in sync with the 2.4 tree  (2.4.3-pre3);  new  patches  plus
README files with some short explanations are can be found in
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/patches/

In case you have problems with the patches, there is a  tarball  with
our current sources in
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.3-pre3-2001-03-11.tar.bz2


Short summary of the new features:

* support for up to 6 serial ports on MPC860 systems
* MPC8xx watchdog support (need appropriate support in the firmware
  which is available with PPCBoot)
* IP860 VMEBus memory support
* IP860 VMEBus interrupt support
* IP860 Real-Time Clock support
* Status LED driver
* AMD   flash chip support
* INTEL flash chip support
* Allow passing a "mem=XXX" boot argument
* fix softemu8xx.o linkage
* "embedded IDE" support (IDE drives connected directly to the 8xx
  PCMCIA port, and for real PCCARD interfaces like CompactFlash or
  harddisk adapter cards, but without need for the full PCMCIA
  package; also usable for boot devices).


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Perfection is reached, not when there is no longer anything  to  add,
but when there is no longer anything to take away.
- Antoine de Saint-Exupery

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
