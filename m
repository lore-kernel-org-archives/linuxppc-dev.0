Message-ID: <39406AF3.9EB0145C@embeddededge.com>
Date: Thu, 08 Jun 2000 23:56:35 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx in 2.4 will boot
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I hope it will for you anyway.

I just pushed the last of the changes into FSM Labs BitKeeper tree.
There were lots of minor changes surrounding MM context and page
table arrangement in the later versions that missed the 8xx port.

I merged a ton of changes into the FEC driver from Magnus, Graham,
and myself for generic PHY support.  Don't even think about complaining
that this doesn't yet work.  I know it doesn't.

The CPU6 silicon errata isn't complete yet.  The major stuff is there,
so chances are it may work if you need it.

I have lots of smaller patches from people that I can now add to
the tree.  If your's isn't there yet, just wait a couple of days
before pestering me again.  I never add anything without testing on
a variety of platforms, including building for my iMac and G4, so it
takes a while to make sure your additions don't break something else.
If you have 2.2.xx patches and want them added to the 2.4 tree (other
than this should have been done long ago into a 2.3 tree), test them
against the 2.4 tree and send them to me.

I have a program for patching the zImage into a reasonable ELF format
that VxWorks boot roms can load.  I'll post that someplace and let
you know.  Perhaps other ELF tools can load it as well.


Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
