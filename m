Date: Sun, 11 Aug 2002 07:54:28 -0400
From: Bill Fink <billfink@mindspring.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: rwaldrop@sbcglobal.net, linuxppc-dev@lists.linuxppc.org,
	Bill Fink <billfink@mindspring.com>
Subject: Re: aic7xxx breakage
Message-Id: <20020811075428.649cbdba.billfink@mindspring.com>
In-Reply-To: <20020811084124.10190@192.168.4.1>
References: <20020811055718.59ebc9bd.billfink@mindspring.com>
	<20020811084124.10190@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

On Sun, 11 Aug 2002, Benjamin Herrenschmidt wrote:

> >Unfortunately, with this change the kernel doesn't even boot, failing
> >very early on with the last messages on screen being:
> >
> >openpic enter
> >openpic timer
> >openpic ext
> >openpic spurious
> >openpic exit
>
> Ok, boot that kernel with the "printkbtext" kernel arg and tell me what
> it says.

OK (that was very painful).  I hope I transcribed it properly (I did
check and doublecheck it but especially the 0s and 8s look very similar).

						-Bill

P.S.  The following was transcribed exactly as it appeared on my
      screen, but due to screen wrapping I believe the actual last
      line output was the one before the two blank lines.



Screen output:
--------------------------------------------------------------------------------
Found 21:78 [106b/0021] 000200 00
Fixups for bus 21
Bus scan for 21 returning with max=21
PCI->OF bus map:
0 -> 0
16 -> 0
17 -> 1
33 -> 0
PCI:00:10.0: Resource 0: 94000000-97ffffff (f=1208), vd: 1002, dev: 5046
PCI:00:10.0: Resource 2: 90000000-90003fff (f=200), vd: 1002, dev: 5046
PCI:11:07.0: Resource 0: 80000000-8007ffff (f=200), vd: 106b, dev: 0022
PCI:21:0f.0: Resource 0: f5200000-f53fffff (f=200), vd: 106b, dev: 0021
PCI:00:10.0: Resource 1: 00802400-008024ff (f=101), vd: 1002, dev: 5046
PCI:11:04.0: Resource 1: 80083000-80083fff (f=200), vd: 9004, dev: 5078
PCI:11:08.0: Resource 0: 80082000-80082fff (f=200), vd: 106b, dev: 0019
PCI:11:09.0: Resource 0: 80081000-80081fff (f=200), vd: 106b, dev: 0019
PCI:11:0a.0: Resource 0: 80080000-800807ff (f=200), vd: 104c, dev: 8020
PCI:11:0a.0: Resource 1: 80084000-80087fff (f=200), vd: 104c, dev: 8020
<3>PCI: Failed to allocate resource 0(0-ff) for 11:04.0
resource conflict with: f3000000..f3ffffff (200), name: /pci@f2000000
<3>PCI: failed to reserve MEM for bus 17
<3>PCI: Device 11:04.0 not available because of resource collisions


Fixups for bus 00
Bus scan for 00 returning with max=00
Scanning bus 10
Found 10:58 [106b/001f] 000600 00
Found 10:68 [1011/0026] 000604 01
Fixups for bus 10
Scanning behind PCI bridge 10:0d.0, config 010100, pass 0
Scanning behind PCI bridge 10:0d.0, config 010100, pass 1
Scanning bus 11
Found 11:20 [9004/5078] 000100 00
Found 11:38 [106b/0022] 00ff00 00
Found 11:40 [106b/0019] 000c03 00
Found 11:48 [106b/0019] 000c03 00
Found 11:50 [104c/8020] 000c00 00
Fixups for bus 11
bridge resource 0, base: 1000, limit: 0
<3>Bridge 10:0d.0 resource 0 was deactivated by firmware
bridge resource 1, base: 80000000, limit: 80000000
bridge resource 2, base: 80000000, limit: 7ff00000
<3>Bridge 10:0d.0 resource 2 was deactivated by firmware
Bus scan for 11 returning with max=11
Bus scan for 10 returning with max=11
Scanning bus 21
Found 21:58 [106b/001e] 000600 00

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
