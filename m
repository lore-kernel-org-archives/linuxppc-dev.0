Message-ID: <01139FC052A0D411900B00508B9535FC0334D03D@ZCH07EXM04.corp.mot.com>
From: Liu HongXun-a16975 <a16975@motorola.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: how to disable the swap on embedded system?
Date: Wed, 26 Sep 2001 15:48:12 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all,
I am running linuxppc 2.4.4( Wolf's version) on my FADS823 board.
Because there is no disk support, I wonder if there is also the need
to use the swap function which load needed page from disk to memory?
If that swap function is not needed, how I can disable such function for
linuxppc?
The current version linuxppc on my FADS823 always gives some problems.
When there is a page fault, the system will halt and oops
Thanks
rolf liu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
