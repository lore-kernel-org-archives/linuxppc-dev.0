Message-ID: <378E6BBE.E5C76CB6@broadlink.com>
Date: Thu, 15 Jul 1999 16:16:14 -0700
From: Scott Wood <scott@broadlink.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: pcmcia-cs on RPX (MPC850)?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone know if there is a version of pcmcia-cs that works on the RPX Lite (MPC850 CPU)?  I have tried compiling sources (ver.
3.0.9) but it generates an error that no bus architectures are defined (MPC850 has neither ISA nor PCI, has own Processor & I/O
busses and PCMCIA in the chip).


-- 
+---------------------+----------------------+
|     Scott Wood      |   Systems  Engineer  |
|=====================+======================|
|           BroadLink Communications         |
+--------------------------------------------+

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
