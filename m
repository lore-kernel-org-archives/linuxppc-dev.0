Date: Mon, 17 Apr 2000 12:57:43 +0200 (METDST)
From: Daniel Haas <Daniel.Haas@cern.ch>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Anyone running LinuxPPC2000+PCMCIA+WallStreet?
In-Reply-To: <200004170459.XAA15116@lists.linuxppc.org>
Message-ID: <Pine.HPP.3.95a.1000417125509.26851R-100000@hpl3bas3.cern.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> From: "Mark S. Mathews" <mark@absoval.com>
>
> We're trying to run a LinuxPPC 2000 install on a WallStreet M4753 and
> trying to get PCMCIA going.  Of course, we've had loads of trouble.  ;-)

One of the important things is to have the right settings in
/etc/pcmcia/config.opts

I use the following on my wallstreet (no extensive tests, but no crashing
yet):

include port 0x000-0xfff, port 0x400-0x4ff, port 0x100-0x1000
include memory 0xa0000000/0xa0ffffff, memory 0x60000000-0x60ffffff

try and see if it works

good luck
Daniel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
