Subject: 405GPr support in linux2.4.18
To: linuxppc-embedded@lists.linuxppc.org
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Tue, 18 Feb 2003 11:11:06 +0100
Message-ID: <OFA7B6F432.6CF96B48-ONC1256CD1.00372BF7@eng.eni.wago.de>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I'm designing a board with 405GP processor. I'm now trying to have it
working with a 405GPr version.
I've started to configure it working in legacy mode and made the necessary
changes in PPCBoot.

Once downloaded, my kernel hung in early_init function when it called the
memset_io to zero the BSS. Using a BDI2000 debugger, I saw that I've
reached the bad_page_fault function.

The only difference I know between 405GP and 405GPr in legacy mode is data
cache size. How does the kernel manage it?

I'm currently using kernel 2.4.18 from Montavista.

Any help is welcome,

Laurent


Laurent MOHIN
ACTERNA


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
