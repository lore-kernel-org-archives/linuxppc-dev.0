Message-ID: <46961.193.133.92.239.1030620615.squirrel@www.solinno.co.uk>
Date: Thu, 29 Aug 2002 12:30:15 +0100 (BST)
Subject: Keyboard in PReP boot loader - desparate for help
From: "Leigh Brown" <leigh@solinno.co.uk>
To: <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm using Hollis Blanchard's patches to get a framebuffer working in the
PReP boot loader, and this is working really well.  In order to be able
to type the command line in, the keyboard needs to work.  However, the
keyboard code in the PReP boot loader does not work on my 7043-140, nor
on a 7024-E30 that I have access to.  The same code works absolutely fine
on a Carolina machine.  In addition to this, the keyboard works fine
once the kernel has booted.

I've been trying to get this working for the last three days and I am
totally stuck.

If anyone has any suggestions as to possible causes for this behaviour
I would be extremely grateful to receive them!

Thanks,

Leigh.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
