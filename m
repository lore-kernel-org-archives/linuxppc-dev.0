Message-Id: <200004071354.JAA03494@hoover.gilbarco.com>
From: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Software Emulation Exception...
Date: Fri, 7 Apr 2000 09:54:04 -0400 
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everyone,

I was hoping you all would pass some knowledge on to me.  Occasionally our
application dies and our board goes into a loop of printing

"Software Emulation %s/%d NIP: %lx *NIP: 0x%x code: %x"

which is coming from arch/ppc/traps.c,

would the fact that I have kernel math emulation turned on increase the
chances of this error.  Without KME the Soft_emulate_8xx routine gets called
and I didn't know if that handled this a little bit better.

Thanks,
Jason

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
