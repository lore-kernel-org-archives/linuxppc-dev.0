Message-ID: <C7FFFEA58B43D311920D0004ACE5333F10E4F316@amer25.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Ashwin Bihari'" <raz0redge@hotmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Linux boot args with PReP image
Date: Fri, 31 Oct 2003 14:05:15 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The old mbxboot boot wrapper had such a prompt for command line.
You could dig it out of source control.

-----Original Message-----
From: Ashwin Bihari [mailto:raz0redge@hotmail.com]
Sent: Friday, October 31, 2003 11:29 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux boot args with PReP image



Greetings,

I'm using a PrPMC800 with Motorola's PPC7-BUG> to boot Linux. I've got a
working kernel and everything works fine. I've used the default boot args
of: console=ttys0,9600 console=tty0 root=/dev/hde2 noinitrd.

This, of course, means that if we decide to change the location of root, or
more appropriately decide to have two separate roots between which we would
have switch back and forth, I'll have to recompile the kernel with the new
string and then put that onto the PReP partition.

What I would ideally like to do is have a Linux: prompt appear after I boot
into the PReP partition to allow me to have a default string and then change
it if I decided to chagne root on the fly..

Has anyone done anything similar or have any tips for me?

Regards,

~Ashwin Bihari


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
