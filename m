Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3670E67B5E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 10:10:28 +1000 (EST)
Message-ID: <4509EF09.9030007@dlasys.net>
Date: Thu, 14 Sep 2006 20:08:41 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: John Bonesio <john.bonesio@xilinx.com>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
References: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA6FA@XSJ-EXCHVS1.xlnx.xilinx.com>
In-Reply-To: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA6FA@XSJ-EXCHVS1.xlnx.xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

John;

    My guess would be that as the whole xilinx drivers/edk stand, even 
with the virulent support of this list I would not bet on their being 
accepted upstream.

    Nothing in the Linux Kernel that I am aware of resembles them.
    There has been on ongoing holy war in LKML over getting reiser4 
accepted as experimental, one of the major issues being coding style. 
The style of reiser4
    is alot closer to Linux norms than the Xilinx EDK code.

    The current Xilinx approach is supposed to easily give us board 
support for varying IP's accross several platforms. I have been 
providing board support for
Pico Computing's Xilinx V4 based offerings for about a year, and I have 
been unable to take advantage of any of that. I have done board bringup 
for two OS's.
While I have been able to benefit from the work of other's on this list, 
and I have been able to occasionally use some code coming from Xilinx - 
mostly as  a reference,
I have two products supporting two operating systems, with a small 
collection of variable peripherals. None of this uses the Xilinx EDK. I 
deliberately postponed
work on the ethernet drivers in the hope they would be finished by the 
time I finished everything else. In the end I had to write my own.

I am not trying to bash Xilinx or Monta Vista. What I am questioning is 
whether the approach that Xilinx is currently using, aside from other 
problems, may actually run
counter to its goal.

If the Xilinx EDK could give us the support we need for the IP's we use. 
If it adapted easily between OS's, and IP versions. And if the code was 
as current as the IP's themselves.
Maybe the Xilinx EDK would be vindicated.

Certainly many of us would use it. While I happen to personally adhere 
to 98% of the Linux Style guidelines - I here many of my own views 
express ed in them, I am not a fanatic.
I am happy if my work improves Linux. But in the end I pay my mortgage 
and feed my family. I will use the resources that get the job done. 
Style is secondary.

But my honest expectation is that MV/Xilinx EDK support will always lag 
way behind what I am trying to do, and/or be incompatible with the goals 
and objectives of my clients.
For me the code coming from Xilinx/MV is most useful as a reference. I 
have ranted about mismatches between documentation and hardware - but 
that is not something new or specific
to Xilinx. What code has leaked out has proven useful - often after 
several days work turning it into something actually readable, as a 
reference - "Oh, that is how that bit really works"

I would be happy to be proven wrong - but I do not expect to be.






-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
