Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Debugging Network Performance
Date: Mon, 3 Jun 2002 21:34:02 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFOEBEDIAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I was wondering if anyone could provide some pointers on monitoring and
debugging network communications. The performance of Ethernet communications
seems to vary with kernel revisions. I would like to analyze this problem
but I need a little guidance on the issue.

TIA!

=========== Previous 8260 Ethernet email ==================

2. Some relative performance measurements (HHL 2.4.2 vs. 2.4.19pre9)
			10T Hub	|	100BT switch
		 -------------------------------------|
	2.4.2	 |	410KBps	|	750KBps	  |
		 -------------------------------------|
	2.4.19 |	440KBps	|	190KBps	  |
		 --------------------------------------

	RedHat 2.4.18-3 (x86)	3900KBps

3. TOP shows as much as 48% system utilization during a single FTP transfer.
With the fix mentioned in #1, there are 0 errors reported by ifconfig.

I may be missing something but I believe that these numbers are going the
wrong way. There is still the question of performance decrease when using a
100BT switch. Signal intregety can not be the only suspect considering the
performance did increase using an older version of the kernel. (although
nothing like the Workstation performance)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
