Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Ricardo Scop" <scop@digitel.com.br>,
	"James Don" <JDon@spacebridge.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: ifconfig: SCC1 enet0 not showing up
Date: Wed, 18 Dec 2002 07:24:33 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFCEFBEAAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200212181320.30854.scop@digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > > eth0: CPM ENET Version 0.2 on SCC1, 00:22:2e:ff:67:de
> > > RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> >
> > 1. cat /proc/net/dev
> >    If eth0 is listed then it is installed in the kernel
> >
> > 2. have you tried to configure the ethernet by hand?
> >    ifconfig eth0 192.168.1.10
> >
> >    Then run ifconfig and see if it shows up.
> >
> > 3. If this works, you can go back and correct your bootline parameters.
> >
>
> Better yet, set CONFIG_IP_PNP in yor kernel configuration and
> recompile it!

Or create an appropriate network configuration script for you installation.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
