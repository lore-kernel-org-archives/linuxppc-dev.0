Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Ashwin Bihari" <raz0redge@hotmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux boot args with PReP image
Date: Fri, 31 Oct 2003 13:28:49 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F64QUsi6dnG8Cq0008719d@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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

_________________________________________________________________
Fretting that your Hotmail account may expire because you forgot to sign in
enough? Get Hotmail Extra Storage today!
http://join.msn.com/?PAGE=features/es


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
