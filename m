Date: Thu, 4 Jan 2001 13:31:37 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: network driver order changes in 2.4
Message-ID: <20010104133135.A22381@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have a second network card in my beige G3 which needs the dc4x5.o
driver. In 2.2 the internal card is eth0 and the second card is eth1.
In test13-ac4 it is reversed. One solution is to have all drivers as
modules, but ...

Is there a way to change the driver init order?



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
