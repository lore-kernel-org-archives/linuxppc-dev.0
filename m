Return-Path: <saiful.khan@sify.com>
Received: from sifyr2.maa.sify.net (sifyr2.maa.sify.net [202.144.76.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A448F67B5B
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 15:07:48 +1100 (EST)
To: WolfgangDenk <wd@denx.de>
Subject: Re: porting ELDK linux for MBX board
Message-ID: <1166501224.458765681921f@mail.sify.com>
Date: Tue, 19 Dec 2006 09:37:04 +0500 (IST)
From: Saiful Khan <saiful.khan@sify.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-MOQ116650122472f4d59d636f062361021275bccdcb4d"
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This message is in MIME format.

---MOQ116650122472f4d59d636f062361021275bccdcb4d
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Quoting  wd@denx.de:

> In message <1166446364.45868f1cabae9@mail.sify.com> you wrote:
> 
> Hi please suggest me how can i port linuxppc_2_4_devel into mbx board, i m new to this. so plese help me.

>This has been done many years ago already. Just use the existing code.

>Best regards,
>Wolfgang Denk

Thanks for your reply. Actually I have created the image using the EDLK, but in controller it stucks on the point "CPM UART driver version 0.04"
I am here sent you the log file:-

## Booting image at 00500000 ...
   Image Name:   Linux-2.4.25
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    517973 Bytes = 505.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.25 (root@localhost) (gcc version 4.0.0 (DENX ELDK 4.0 4.0.0)) #1 Thu Dec 14 11:32:41 EST 2006
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=10.0.0.2:/opt/eldk/ppc_8xx nfsaddrs=10.0.0.99:10.0.0.2
Decrementer Frequency = 360000000/60
Calibrating delay loop... 95.64 BogoMIPS
Memory: 63544k available (924k kernel code, 236k data, 44k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART driver version 0.04


Please suggest me.

Thanks and regards
Saiful
---MOQ116650122472f4d59d636f062361021275bccdcb4d
Content-Type: text/html
Content-Transfer-Encoding: 8bit

<pre>Quoting  wd@denx.de:

> In message<br><1166446364.45868f1cabae9@mail.sify.com> you wrote:
> 
> Hi please<br>suggest me how can i port linuxppc_2_4_devel into mbx board, i m new to<br>this. so plese help me.

>This has been done many years ago already.<br>Just use the existing code.

>Best regards,
>Wolfgang Denk

Thanks<br>for your reply. Actually I have created the image using the EDLK, but in<br>controller it stucks on the point "CPM UART driver version 0.04"
I am<br>here sent you the log file:-

## Booting image at 00500000 ...
  <br>Image Name:   Linux-2.4.25
   Image Type:   PowerPC Linux Kernel Image<br>(gzip compressed)
   Data Size:    517973 Bytes = 505.8 kB
   Load<br>Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ...<br>OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.25<br>(root@localhost) (gcc version 4.0.0 (DENX ELDK 4.0 4.0.0)) #1 Thu Dec 14<br>11:32:41 EST 2006
On node 0 totalpages: 16384
zone(0): 16384<br>pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:<br>root=/dev/nfs rw nfsroot=10.0.0.2:/opt/eldk/ppc_8xx<br>nfsaddrs=10.0.0.99:10.0.0.2
Decrementer Frequency =<br>360000000/60
Calibrating delay loop... 95.64 BogoMIPS
Memory: 63544k<br>available (924k kernel code, 236k data, 44k init, 0k highmem)
Dentry<br>cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash<br>table entries: 4096 (order: 3, 32768 bytes)
Mount cache hash table<br>entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries:<br>4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384<br>(order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux<br>NET4.0 for Linux 2.4
Based upon Swansea University Computer Society<br>NET3.039
Initializing RT netlink socket
Starting kswapd
CPM UART<br>driver version 0.04


Please suggest me.

Thanks and<br>regards
Saiful</pre>

<br><A HREF="http://ads.sify.com/RealMedia/ads/click_nx.ads/mail.sify.com/sentmail@Bottom" target=_new>
<IMG SRC="http://ads.sify.com/RealMedia/ads/adstream_nx.ads/mail.sify.com/sentmail@Bottom"  width=300 height=40 border=0></a>
<br>Watch latest movie trailers and behind the scenes footage of Bigg Boss and Zee Cine Stars and much more! <a href="http://www.sifymax.com/" target="_blank">www.sifymax.com</a></br>
<br>See what's happening in your favourite City on Mumbai Live! <a href="http://www.mumbailive.in/" target="_blank">www.mumbailive.in</a></br>

---MOQ116650122472f4d59d636f062361021275bccdcb4d--
