From: clark@esteem.com
Message-Id: <1.5.4.32.20000925230848.006afd8c@pop.esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 25 Sep 2000 16:08:48 -0700
To: "Navin Boppuri" <nboppuri@trinetcommunication.com>
Subject: Re: NFS problem
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 02:27 PM 5/26/00 +0100, you wrote:
>
>Hello,
>
>I am trying to boot my custom board with the linux 2.2.13 kernel. It boots
>OK but when it tries to do the NFS mount, it fails....... This is how it
>looks. I dont understand what's going on. I testing the NFS server with some
>other board and same ip's and it works fine. Any ideas????
>
>lcd_lcvcr: 78000
>loop: registered device at major 7
>eth0: CPM ENET Version 0.2, 08:00:22:50:70:63
>PPP: version 2.3.10 (demand dialling)
>TCP compression code copyright 1989 Regents of the University of California
>PPP line discipline registered.
>Looking up port of RPC 100003/2 on 216.118.31.76
>neighbour table overflow
>neighbour table overflow
>neighbour table overflow
>eth0: transmit timed out.
> Ring data dump: cur_tx ff0028d0 (full) cur_rx ff0028c8.
>dc00 002a 0015c642
>dc00 002a 0015c6e2
>dc00 002a 0015c782
>dc00 002a 0015c962
>dc00 002a 0015ca02
>dc00 002a 0015caa2
>dc00 002a 0015c502
>fc00 002a 0015cb42
>9c00 005a 00174000
>9c00 0076 00174800
>9c00 0076 00161000
>9c00 0076 00161800
>9c00 0040 00160000
>9c00 0040 00160000
>9c00 0076 0015f000
>b000 7edd 0015f800
>eth0: tx queue full!.
>neighbour table overflow
>eth0: transmit timed out.
>
>and it goes on and on. After some time, it says server returned error -5 and
>then tries a reboot. What's going on???
>
>Navin.
>
>
>


        Are you sure you compiled your kernel to use the correct SCC port
for your ethernet interface on the custom board? I have made this mistake
and it produced very simmilar results. Try changing it and see if this fixes it.

Hope this helps,

        Conn Clark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
