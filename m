Message-ID: <EFB813091B18D511BD3600508B644F820A617EC8@tx14exm06.ftw.mot.com>
From: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
To: "'Brian Hawley'" <bhawley@luminex.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: baud rate question
Date: Thu, 13 May 2004 16:08:12 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you're using U-Boot as your Linux bootloader then probably the only thing
you need to do is to pass your desired baud rate through the bootargs as
follows:
console=ttyS0,<baud_rate>

Here's my sample bootargs setting for 115200 baud rate:
bootargs=root=/dev/nfs nfsroot=198.185.4.28:/home/visitor/exports/target
ip=198.185.4.88:198.185.4.28:198.185.4.1:255.255.255.0:mytarget:eth2:off
console=ttyS0,115200

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
