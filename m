Message-Id: <200210221537.RAA23935@ipnmail.in2p3.fr>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Michel =?iso-8859-1?q?D=E4nzer?= <michel@daenzer.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: just compiled a 2.4.19 kernel with smp support...
Date: Tue, 22 Oct 2002 17:34:08 +0200
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.OSF.3.91.1021022160554.3474A-100000@ipnosl.in2p3.fr> <20021022163130.5160@192.168.4.1> <1035299550.1129.1812.camel@tibook>
In-Reply-To: <1035299550.1129.1812.camel@tibook>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Not necessarily if you're booting with video=ofonly. cat /proc/fb
[root@ipnnarval ~]# cat /proc/fb
0 OFfb /pci@f0000000/ATY,PheonixParent@10/

> > I think support for the 9000 have been added to XFree CVS
> > recently, though that may not yet be in the DRI one (and
> > so Michel snapshots). The XFree CVS is beeing merged
> > again into the DRI one now, so this should be fixed soon.
>
> Yep, and in the meantime, you could try telling the radeon driver to
> treat it like a 8500 with the ChipID or Chipset directive.
What do I need to put ? There is 4 different RADEON 8500 ?

xavier

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
