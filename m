Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <39351781.B4B61265@lucent.com>
Date: Wed, 31 May 2000 08:45:37 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: Daris Nevil <Daris.Nevil@snmc.com>
Subject: Re: Do you have your minimum ramdisk image which can provide basic
 network services ?
References: <020e01bfc93f$5dc075c0$db52df8d@helsinki> <3934086C.87BF893@lucent.com> <39340AC7.689BFF86@snmc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daris Nevil wrote:
> The quick-and-dirty way of enabling your loopback device
> is:
>     ifconfig lo 127.0.0.1

Yes, I did that; I get:
	$ ifconfig lo 127.0.0.1
	127.0.0.1: Resolver Error 0 (no error)
	Usage: ifconfig [-a] [-i] [-v] interface
	                [inet address]
	                [hw] [ax25 address]
	                [metric NN] [mtu NN]
	                [trailers] [-trailers]
	                [arp] [-arp]
	                [netmask aa.bb.cc.dd]
	                [dstaddr aa.bb.cc.dd]
	                [mem_start NN] [io_addr NN] [irq NN]
	                [[-] broadcast [aa.bb.cc.dd]]
	                [[-]pointopoint [aa.bb.cc.dd]]
	                [up] [down] ...

I have no idea what "Resolver error 0" is, nor why ifconfig thinks
that is an invalid command line....

	$ ping 127.0.0.1
	ping: unknown protocol icmp.

I think I need to be running inetd to implement the ping protocol, and
so far I have been unable to find a PowerPC image of inetd.

My /etc/protocols has icmp listed (copied from a working i386 linux).
I may have more serious errors, like incompatible libraries....


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
