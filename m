Message-ID: <36ACDDB2.6DA8ACA7@mitre.org>
Date: Mon, 25 Jan 1999 16:10:12 -0500
From: Frank McPherson <frank@mitre.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: xmon, BAT structure, etc.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


xmon doesn't seem to exist in the linuxppc sources any more and I'm
having trouble getting the one from the linuxppc.org 2.1.24 sources to
compile with 2.2.0-pre5, which is the latest version I was able to pull
from vger's anonymous cvs before it started always refusing connections.
  Where can I get it, or something equivalent?  What's the best way to
debug the platform-specific code that's run shortly after the
bootloader?  

I'm working on getting linux up and running on a non-prep, non-pci VME
board with a 603e and having some trouble with it.  I've got the kernel
uncompressing down to where it should be, but it traps when it gets a
bit of the way in to init/main.c.  When I write the contents of the BAT
structure to dual port RAM on the VME bus, I get all zeros, leading me
to believe I'm not setting thins up correctly down in the
platform-specific sections.  

Thanks,

Frank

-- 
Frank H. McPherson IV
The MITRE Corporation

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
