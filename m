Message-ID: <3C9B99DC.7C9C769F@aquilagroup.com>
Date: Fri, 22 Mar 2002 13:53:48 -0700
From: Jeff Studer <jstuder@aquilagroup.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: eth0 : time out ....error
References: <001601c1bff5$4c5b0210$17f2fea9@genetelhychon>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is this with the FEC driver? I have the same problem with the FEC driver in
kernel version 2.4.2.  I would like to hear any solutions to this problem,
too.

ÀüÇý¿µ wrote:

> Hi!
>
> I have the problem when I get/recevie data of over 100 kbytes size
> If I send a small size data , it's trance success
> but big size data is fail and print following messages
>
> why not transmit the big size data(over 100kbyte)??
>
> help me  and thanks for your answers!!
>
> ===  LOG message  =============
>
> 1) small size data
>
> sh-2.03# ftp pc
>
> Connected to pc.
> 220 ProFTPD 1.2.1 Server (ProFTPD Default Installation) [tree.com]
> Name (pc:root): hukim
> 331 Password required for hukim.
> Password:
> 230 User hukim logged in.
> Remote system type is UNIX.
> Using binary mode to transfer files.
>
> ftp> get btd
> local: btd remote: btd
> 200 PORT command successful.
> 150 Opening BINARY mode data connection for btd (27545 bytes).
> 226 Transfer complete.
> 27545 bytes received in 0.017 secs (1.6e+03 Kbytes/sec)
>
>  ==========================================================> "success"
>
> 2) big size data
>
> ftp> get bt.o
> local: bt.o remote: bt.o
> 200 PORT command successful.
> 150 Opening BINARY mode data connection for bt.o (138660 bytes).
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out.
> Ring data dump: cur_tx c1f70078, dirty_tx c1f70078 cur_rx: c1f70038
>  tx: 8 buffers
>   c1f70040: 1c00 0042 01f714be
>   c1f70048: 1c14 0042 01f71dbe
>   c1f70050: 1c00 0042 01f71bbe
>   c1f70058: 1c0c 0042 01f716be
>   c1f70060: 1c00 0042 01f71cbe
>   c1f70068: 1c04 0042 01f715be
>   c1f70070: 1c00 0042 01f71ebe
>   c1f70078: 3c24 0042 01f717be
>  rx: 8 buffers
>   c1f70000: 8800 0446 01f6f000
>   c1f70008: 8800 0446 01f6f800
>   c1f70010: 8800 0446 01f6e000
>   c1f70018: 8800 0446 01f6e800
>   c1f70020: 8800 0446 01f6d000
>   c1f70028: 8800 0446 01f6d800
>   c1f70030: 8800 0446 01f6c000
>   c1f70038: a800 0446 01f6c800
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out.
> Ring data dump: cur_tx c1f70078, dirty_tx c1f70078 cur_rx: c1f70008
>
>  ( ... )
>  ===========================================================> fail
>

--
Jeff Studer
Software Engineer
Aquila Technologies Group

jstuder@aquilagroup.com
office:  505-796-3859


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
