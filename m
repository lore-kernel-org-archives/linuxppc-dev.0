Message-ID: <3874E237.57063BBE@mitre.org>
Date: Thu, 06 Jan 2000 13:43:03 -0500
From: Charles Lepple <clepple@mitre.org>
MIME-Version: 1.0
To: toa@pop.agri.ch
CC: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: remote debugging?
References: <3874C8D8.835DBC64@pop.agri.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andreas Tobler wrote:
[...]
> The kernel is compiled with xmon included, the one I test boots and is a
> 2214pre18. It's only to find out how 'remote' works.

Once you have a kernel with xmon support, you can generate an NMI
(command-power, I believe) and that drops you into xmon (assuming the
machine is not too far gone). In addition, xmon will come up when a
fatal exception occurs, or when you put a xmon(0) call into a function
in the kernel.

When debugging an embedded system, I just put a bunch of xmon(0) calls
at strategic locations, and when I got close to where the system was
hanging, I poked around with xmon.

Paul Mackerras wrote some documentation for xmon that you may want to
check out. It doesn't seem to be in Documentation/ but it's probably at
linuxppc.cs.nmt.edu or something (search the mail archives -- it has
been discussed before).

-- 
Charles Lepple
clepple@mitre.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
