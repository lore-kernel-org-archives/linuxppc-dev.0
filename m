Message-ID: <375FB1BE.1789E049@switchboard.ericsson.se>
Date: Thu, 10 Jun 1999 14:38:23 +0200
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: R&D <iyd@sepac.com.mx>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help booting MBX through bootd
References: <199906091737.MAA25209@www.albec.net.mx>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there!

There are a few problems today with 8xx linux.
People out there: Correct me if I'm wrong.

I blame some of the strange problems on silicon bugs 
in the mpc860 chip. Read the chip errata.

My MBX board has a XPC860ENZPA.
I think I have a C1 chip on a other board which works better.

The memory management is a bit strange.
On some boards is it neccesary to reserve a few tlb entries.

One other problem is that the 8xx series don't have a fpu.
That is not a kernel problem, more a libc problem.

The last problem I know is that the 8xx has a smaller 
(4 words) cahce line length compared to 60x.

I think you should get a crosscompiler.

Cheers /

Magnus

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
