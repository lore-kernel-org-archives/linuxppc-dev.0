From: Michel Lanners <mlan@mcp.cpu.lu>
Message-Id: <199908131531.RAA12476@mcp.cpu.lu>
Subject: Re: Printing via lpr from Mac to LinuxPPC
To: somalley@cdp.mde.state.mi.us
Date: Fri, 13 Aug 1999 17:31:48 METDST
Cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v04003a01b3da00b8cde8@[204.22.210.180]>; from "sean o'malley" at Aug 13, 99 11:15 am
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Sean,

> Has anyone gotten LinuxPPC to be a print server for the lpr print queue
> using the apple laserwriter software to the linuxpcc box than to a printer?

No....

> I tried once a while back with Linux x86 but I gave up when after a couple
> of weeks of not getting it to work.

I tried hard as well, but it seems the Apple LPR driver creates bad control
files. The data gets transfered to the LPR spool area, but then lpd cannot
run the print job. Sadly, lpd doesn't give many error messages neither, just
something along the lines 'Job could not be printed'....

Even worse, Laserwriter on a 68k Mac wouldn't even get the queue name right:
it dropped a character from the configured queue name, so lpd refused the job
:-((

> I would be more than willing to write up some docs on how to do this if I
> can get it to work...

You might want to stop lpd from actually printing (use lpc, and then some 'stop'
or similar command), and check the files Apple's LPR creates. The data file
should be OK, but there is some issue with the control file.

I didn't have time (nor leasure...) to go on debugging; I was going to install
netatalk on the Linux box instead ;-)

Michel

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
