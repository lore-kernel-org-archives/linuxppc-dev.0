Message-ID: <3C6D0D48.413600B6@ardistech.com>
Date: Fri, 15 Feb 2002 14:29:44 +0100
From: "bart@ardistech.com" <bart@ardistech.com>
Reply-To: bart@ardistech.com
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: HZ=1000 network problem?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm running HH Journeyman 2.0 linux-2.4.2 on a 66MHz RPX Lite with root
over nfs. When HZ=100 everything works fine. When HZ=1000 the last prints
I get are

>MTD flash: Found 4 x16 CFI devices at location 0 in 8 bit mode
> Amd/Fujitsu Extended Query Table v1.2 at 0x0040
>number of CFI chips: 1
>NET4: Linux TCP/IP 1.0 for NET4.0
>IP Protocols: ICMP, UDP, TCP, IGMP
>IP: routing cache hash table of 512 buckets, 4Kbytes
>TCP: Hash tables configured (established 4096 bind 4096)
>IP-Config: Guessing netmask 255.255.0.0

Does this sound familiar to anybody?

Regards,
	Bart

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
