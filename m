From: "Jon Erick Ween" <jween@som.llu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.0-pr-ac5, irda problems and empty modules.dep file
Date: Fri, 5 Jan 2001 12:37:22 -0800
Message-ID: <7744FF58E8A.AAA32E7@som.llu.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello everyone

I recently upgraded to the 2.4.0 prerelease-ac5 kernel (off the bk tree) to
run on a Lombard powerbook. mostly the config and compilation went smoothly
(XF4 and usb works great) except for the following:

1) trying to compile in irda resulted in a an error with irda_cleanup:

net/network.o: In function `irda_cleanup':
net/network.o(.text.exit+0x8c): undefined reference to `irttp_cleanup'
net/network.o(.text.exit+0x8c): relocation truncated to fit: R_PPC_REL24
irttp_cleanup
ERROR 1

2) although I compiled in module support and the modules were created and
installed, I wind up with an empty modules.dep file and the kernel
obviously fails to locate them. (I upgraded to the 2.3 version of modutils
as well). I've even tried to manually write the modules.dep, patterning it
on the old 2.2.18 one though with propper paths, but still the kernel fails
to find any modules and the modules.dep file seems to get erased after boot
up.

Any ideas as to what's going on here? Thanks!

Jon

Jon Erik Ween, MD
Assistant Professor
Cognitive and Cerebrovascular Neurology
Loma Linda University


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
