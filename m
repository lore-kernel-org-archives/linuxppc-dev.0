Date: Mon, 28 Feb 2000 10:44:08 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: Patrick Lerda <Lerda@microprocess.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: RE: Stability of 2.3.47 (G4)
In-Reply-To: <B0CAE42C9EE0D311AAAD00500422FC6302CD80@iis000.microdata.fr>
Message-ID: <Pine.LNX.4.10.10002281042320.709-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 28 Feb 2000, Patrick Lerda wrote:

> I try linux 2.3.47 on an other kind of PowerPC box, a 740 with a PCI bus.
> The kernel start, but my NE2000 or my tulip board don't work in an
> nfs mode. The IDE driver crash, and The adaptec driver don't work too.
> Otherwise USB seems to work, and my framebuffer works...

Well, the ne2k-pci driver may or may not have been fixed finally (yes, it
is/was an endian issue and was patched.  I think the patch stuck tho).  As
for the tulip board, do not use the tulip driver, use de4x5.  I've tried 3
tulip cards with tulip.c 0.91g-ppc and none of them have worked. (a real
tulip, a lite-on and a maxtronic or something wierd like that).

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
