Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "James Don" <JDon@spacebridge.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: ifconfig: SCC1 enet0 not showing up
Date: Wed, 18 Dec 2002 07:08:53 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFCEEPEAAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <DB0585C9F6F9D411BE8F00D0B7896A4CC05F4E@SNCMAIL>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> # ifconfig
> lo        Link encap:Local Loopback
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

snip

> ...
> eth0: CPM ENET Version 0.2 on SCC1, 00:22:2e:ff:67:de
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

1. cat /proc/net/dev
   If eth0 is listed then it is installed in the kernel

2. have you tried to configure the ethernet by hand?
   ifconfig eth0 192.168.1.10

   Then run ifconfig and see if it shows up.

3. If this works, you can go back and correct your bootline parameters.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
