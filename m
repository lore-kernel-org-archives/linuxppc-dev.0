Message-ID: <3439AB3A99ECD5409F3A52ACF814744D158D6F@norcom2.norcom.net>
From: Lokesh Kumar <lokesh.kumar@wrx-us.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: mic2563 dual slot pcmcia controller
Date: Thu, 28 Aug 2003 14:45:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a mpc8xx based board, which has two pcmcia slots, and uses micrel
2563a power controller. Now, I understand that I have to control this in the
file drivers/pcmcia/m8xx_setup.c file. I was wondering if anybody has done
the same and can tell me what is the right way. Also, where do I set the
other pcmcia related values for example pbr0, memory size etc? Any pointers
would be helpful.

Thanks in advance.

Lokesh Kumar
Wireless Matrix USA Inc.
703-262-4032


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
