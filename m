Date: Thu, 21 Sep 2000 20:03:42 +0530 (IST)
From: Ankush Varma <ee97220@agasthya.ee.iitm.ernet.in>
To: Wojciech Kromer <krom@dgt-lab.com.pl>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: linux on MPC850FADS
In-Reply-To: <39ADFF02.70188A38@dgt-lab.com.pl>
Message-ID: <Pine.LNX.4.04.10009211952360.25898-100000@agasthya.ee.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Mr. Kromer,

I'm still having problems with 8xxrom on the MPC850 FADS.
- It compiles properly.
- I obtained 8xxrom.bin.s19 and loaded it to flash.
- switched board off
- disconnected ADI port
- switched board on.

The board just hangs. The green "run" LED stays on, but nothing happens.

I put some assembly code to switch an auxiliary LED on into start.S, but
still nothing happened. I don't know what is going on. Did you also face
similar problems? Do you have some idea what my problem might be?

Thank you,
Ankush

-----------------------------------------------------------------------------
Ankush Varma
Senior Year Undergraduate Student
Indian Institute of Technology, Madras, India

email: ankush@ee.iitm.ernet.in,ankushv@hotmail.com,ankush@somethingorother.com
-----------------------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
