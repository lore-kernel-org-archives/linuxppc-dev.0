Message-ID: <0B0A39652BB0D411BCCF00508B9512EC08AEB468@tx14exm05.ftw.mot.com>
From: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8260 core/bus/cpm clock
Date: Thu, 10 Oct 2002 08:35:40 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


After dumping cpu information,

# cat /proc/cpuinfo
cpu             : 82xx
core clock      : 132 MHz
CPM  clock      : 66 MHz
bus  clock      : 33 MHz
revision        : 1.1 (pvr 0081 0101)
bogomips        : 54.88

I found this is NOT correct for the custom board. It should be
66/133/166MHZ. However
I did not find any configurable entry in "make xconfig".

Thanks.

Bo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
