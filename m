From: iweiny@pacbell.net
Date: Tue, 09 Nov 1999 09:12:29 -0800 (PST)
Subject: __module_kernel_version <= what is this?
To: linuxppc-dev@lists.linuxppc.org (linuxdev)
Message-id: <199911091712.JAA01251@batcave2.localdomain>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am getting the following error when compiling the new USB modules
against the 2.2.12 kernel.  I have been unable to find this symbol
in either the assembly or preprocessed outputs?  What is this?

details
2.3.26 USB code compiled against the 2.2.12 stable Pmac tree.
While linking usb.o usb-debug.o ohci.o ohci-debug.o together...

ohci.o(.modinfo+0x0): multiple definition of `__module_kernel_version'
usb.o(.modinfo+0x0): first defined here
gmake: *** [usb-card-driver.o] Error 1

Where is this defined and how can I make it defined in only one file?
I would like just one object for the "card-driver" which worked with
the cvs USB source from ppc.kernel.org.

Ira Weiny
iweiny@acm.org

PS. The main goal of this is to get USB support working for my DC265
Kodak camera.  Once that is up I am going to try and get the OpenDis
driver to work and I should have FAST jpeg downloads from my camera.
The 2.3.26 source from kernel.org has a dc2xx driver in it which is 
supposed to work but I was hoping to still use the 2.2.12 stable
kernel that I have...

PPS this work should extend to the DC260 and DC290 and DC280 Kodaks
if anyone has them.  (And maybe other USB equiped cameras but I don't
know too much about the driver itself.)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
