Message-Id: <3.0.3.32.20020822173918.006dbb00@hollabaugh.com>
Date: Thu, 22 Aug 2002 17:39:18 -0600
To: Marius Groeger <mag@sysgo.de>,
	John Fisher <John.Fisher@nec.com.au>
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: RE: cygwin and embedded linux
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.40.0208220914420.2118-100000@mag.devdep.sysgo.d
 e>
References: <000501c24979$6348a190$37d34c93@neca.nec.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 09:36 AM 8/22/2002 +0200, Marius Groeger wrote:
>2. The "emulation" will never be 100%. Maybe 99%. Maybe 99.99%. That last
>   fraction can be a major PITA, because it is not obvious. To compile a
>   kernel you need a lot of tools with a lot of explicit and implicit twists
>   to them. It is just a gut feeling that I wouldn't want to rely on this,
>   if I don't have to. The native way just seems the better way to do it to
>   me.

Just because your running on Linux doesn't mean anything because your duplicating
the environment for cross-compiling anyway. So what does it matter if cygwin runs
the cross tools or if Linux runs them?



I'm curious ...

How many out there actually are compiling PPC code natively on a PowerPC Linux box for their embedded devices?

If so, do you run the same development versions on your desktop?

How do you handle the FPU issues?

Craig


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
