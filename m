Reply-To: <myung.choi@gtri.gatech.edu>
From: "Myung Choi" <myung.choi@gtri.gatech.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: HZ value in the kernel
Date: Tue, 9 Jan 2001 20:21:04 -0600
Message-ID: <NDBBIAJKOKHJKMPEIAIMAEOCCGAA.myung.choi@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear LinuxPPC-embedded Group,

I have one question related to the value of HZ in /include/asm-ppc/param.h.
This value is set to 100 which gives 10 ms for jiffies. As long as I know,
the value, 100, is what ix86 provides, and alpha chip takes higher number
for HZ. I am wondering if this is true for PPC (expecially for MPC823 chip).
Can I change the value to, for example, 400 or 500 to get 2.5 ms or 2 ms for
jiffies? Can MPC823 take the higher than 100 for its HZ?

Thanks for your help in advance.

Myung.

---
Myung C. Choi, Research Engineer II
Information Technology & Telecommunications Laboratory
Georgia Tech Research Institute
Atlanta, Georgia, 30332-0855
Phone: (404) 894-3016 Fax: (404) 894-6634
Email: myung.choi@gtri.gatech.edu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
