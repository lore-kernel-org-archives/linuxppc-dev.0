Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC06036@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: RAMDISK IMAGES: why no ethernet in my image ... but denx ok 
Date: Sun, 12 Jan 2003 14:15:19 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As well:

1.) If I "cat /proc/net/dev" eth0 and lo are there ...
2.) If I "ipconfig eth0 192.168.34.67" I can ping as well ...

Jim

-----Original Message-----
From: James Don
Sent: Sunday, January 12, 2003 1:08 PM
To: 'Wolfgang Denk'; James Don
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: RAMDISK IMAGES: why no ethernet in my image ... but denx ok

Hi All,

I just managed to create my first ram-disk image. Which seems to work more
or less ... however my Ethernet doesn't seem to get configured with my ram
disk image (see out put below) ...

What would cause this? I believe it may be a startup script or something ...
but I am still learning where all this is done ... any tips would be
appreciated ...

Best Regards.
Jim

MY IMAGE:
=========
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0


DENX IMAGE:
===========
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Complete:
      device=eth0, addr=192.168.104.101, mask=255.255.255.0,
gw=192.168.104.1,
     host=BigMoney, domain=, nis-domain=(none),
     bootserver=192.168.103.151, rootserver=192.168.103.151, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
