Message-ID: <396B0E65.DDA6AEE@charter.net>
Date: Tue, 11 Jul 2000 07:09:09 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Kwansuk Kim <kskim@neowave.co.kr>
CC: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: network tools don't work
References: <NEBBKFENMLEDKDHMEHPJIEOOCAAA.kskim@neowave.co.kr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kwansuk Kim wrote:
>
> After getting bash prompt, I determined wheather network is working, but it doesn't.
> It tells there is no protocol.
>
> ----------
>
> init-2.00# ./ifconfig lo 127.0.0.1
> 127.0.0.1: Resolver Error 0 (no error)
...
> init-2.00# ping 210.105.51.96
> ping: unknown protocol icmp.
> init-2.00#
...
> Is something wrong?
>
> I used ramdisk root file system, and ramdisk image was obtained from linuxppc.org. (about 4Meg, library version is 1.99)

What is wrong is that there is no /etc/protocols file.
Try it:
	# mv /etc/protocols /etc/protocols.none
	# ping 127.0.0.1
	ping: unknown protocol icmp.
	# mv /etc/protocols.none /etc/protocols

-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
