Message-Id: <000e01bf9b78$2f2073e0$0602a8c0@cs.tsinghua.edu.cn>
From: "Wang Yong" <wung_y@yahoo.com>
To: "Mike Wolf" <mwolf@sgi.com>, <linuxppc-embedded@lists.linuxppc.org>
References: <38E3CE55.977E302@cray.com>
Subject: Re: 4xx tlb questions
Date: Sat, 1 Apr 2000 09:18:16 +0800
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


the PID reg corresponds to TID field of TLB Entry when
new entry is inserted and va is translated. if the TID of
some entry is set to 0, then this entry can be used for
translation by every process. in scenario of creating
new TLB entry and process switching, you should set PID
reg. and the TLBs used by virtual space of kernel is inserted
into TLB with the TID set as 0 so that PID need not to be
changed when enter kernel(system call or interrupt and so on).

w.y.
--
Wang Yong - DCS at Tsinghua Univ.

EMAIL: wyong@acm.org (CC to wung_y@yahoo.com pls :-)
PHONE: 010-62788076(Lab)
       010-62775899(Dorm)
Dorm : 22#606, Tsinghua Univ.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
