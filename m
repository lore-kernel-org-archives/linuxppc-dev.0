Date: Fri, 17 Dec 1999 19:44:07 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: New Set of PowerPC 4xx Patches Are Up
Message-ID: <Pine.SGI.4.10.9912171941480.66466-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Check the following for today's patches:

	http://www.lcse.umn.edu/~grant/Linux/

Updated:

- Changed the treeboot boot loader to allow for passing in a static (i.e.
  configured prior to compilation) set of command line arguments into the
  kernel. This will have to suffice until the IBM boot ROM or the boot
  loader provide a way to do it interactively. 

- Fixed a glaring error within ppc4xx_pic.c which prevented 
  ppc403_aic_disable_and_ack from working correctly. 

- Implemented the bulk of the code for National Semiconductor DP83902AV
  "Oaknet" Ethernet support in oaknet.c (mostly copied from ne.c). That
  said, it does not quite work yet. It seems close. 

- Temporariliy pinned a TLB entry to cover the Oaknet memory-mapped I/O
  space. I'm sure there's a more generic way to do this, but I haven't
  figure it out yet. 


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
