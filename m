Message-ID: <3E8FE0BE.1070002@tataelxsi.co.in>
Date: Sun, 06 Apr 2003 13:39:34 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linux-india-programmers@lists.sourceforge.net,
	linuxppc-embedded@lists.linuxppc.org
Subject: mpc8260 Multi channel controller howto and kernel driver code
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I have published a howto on programming mpc8260 Multichannel
communication controller using linux on www.tldp.org.

Link here.
http://tldp.org/authors/inprogress.html
Draft is available on
http://ibiblio.org/gferg/ldp/MPC8260-MCC-HOWTO.txt

Any feedback on this is welcome.

Driver code for this will be published at the end of may,2003. I am
testing the driver code. If anybody is interested, please contact me
offlist.

Present driver code (being tested) offers the follwoing functionalities
1.Programming MCC1 and MCC2, all 256 channels.
2.Super channels for Tx
3.HDLC Mode for Tx and Rx.
4.LDISC interface.
5.Full testing functionality for execution paths using IOCTLs (like
SIRAM contents dumping, MCC gloabal parameter dumping, Buffer descriptor
dumping (both data as well as BD contents). Around 18 ioctls
implemented, if time permits I will implemnt less important ones.
6.Ready for using E1 as well as T1 channelized interfaces.
7.With minor tweaks, single channel E1 and T1 interoperability.

Proposed Improvements
1. real time snapshot of testing/debugging functionality using /proc
2. Transparent mode of operation.

Thanks and regards,
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
