Date: Thu, 7 Feb 2002 14:35:06 -0800
From: Jeffery von Ronne <jronne@ics.uci.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: two aty128 frame buffers?
Message-ID: <20020207143506.H3189@reepicheep.ics.uci.edu>
References: <Pine.LNX.4.43.0202071127340.16392-100000@andromeda.dsdk12.net> <Pine.BSF.4.44.0202071122270.40334-100000@shell.unixbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.BSF.4.44.0202071122270.40334-100000@shell.unixbox.com>; from ajoshi@shell.unixbox.com on Thu, Feb 07, 2002 at 11:26:43AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 07, 2002 at 11:26:43AM -0800, Ani Joshi wrote:
> Yes, unfortunately though people on AGP G4's tend to use an AGP and a PCI
> card.  I suppose they could do what you are doing and use the bottom 2 (or
> however it works on G4s) PCI cards if they have 2 PCI boards.

This, is actually--I think--the setup I have: two PCI R128s on an AGP
G4.  cat /proc/pci shows an AGP bus 0, PCI bus 1, a PCI bus 2 (which
has all of the real devices, including my two R128 video cards) and
most of the internal PCI stuff, and a PCI bus 3.

FYI, on bootup I get some PCI errors related to the video cards:
  PCI:02:03.0: Resource 0: 84000000-87ffffff (f=1208)
  PCI: Cannot allocate resource region 0 of device 02:03.0
  PCI:  parent is c03c0068: 80000000-8fffffff (f=200)
  PCI:02:03.0: Resource 2: 80088000-8008bfff (f=200)
  PCI:02:07.0: Resource 0: 80000000-8007ffff (f=200)
  PCI:02:02.0: Resource 0: 88000000-8bffffff (f=1208)
  PCI: Cannot allocate resource region 0 of device 02:02.0
  PCI:  parent is c03c0068: 80000000-8fffffff (f=200)
  PCI:02:02.0: Resource 1: 00001000-000010ff (f=101)
  PCI:02:02.0: Resource 2: 8008c000-8008ffff (f=200)
  PCI:02:03.0: Resource 1: 00001000-000010ff (f=101)
  PCI: Cannot allocate resource region 1 of device 02:03.0
  PCI:  parent is c261b924: 00001000-00001fff (f=101)
  PCI:02:08.0: Resource 0: 80083000-80083fff (f=200)
  PCI:02:09.0: Resource 0: 80082000-80082fff (f=200)
  PCI:02:0a.0: Resource 0: 80081000-800817ff (f=200)
  PCI:02:0a.0: Resource 1: 80084000-80087fff (f=200)
  PCI:02:0b.0: Resource 0: 00001000-0000107f (f=101)
  PCI: Cannot allocate resource region 0 of device 02:0b.0
  PCI:  parent is c261b924: 00001000-00001fff (f=101)
  PCI:02:0b.0: Resource 1: 80080000-800803ff (f=200)
02:02.0 is my /dev/fb0 ATI R128
02:03.0 is my /dev/fb1 ATI R128
02:0b.0 is my tulip ethernet chip

PS. My full /proc/pci and dmesg are at http://www.ics.uci.edu/~jronne/tmp

--
Jeffery von Ronne <jronne@ics.uci.edu>
Graduate Student
Information and Computer Science
University of California, Irvine


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
