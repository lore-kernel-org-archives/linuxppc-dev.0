Message-ID: <376AD199.43D25@mrv.com>
Date: Fri, 18 Jun 1999 16:09:13 -0700
From: Nye Liu <nyet@nbase.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Motorola MPC8240 Sandpoint embedded linux
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have just started work on the MPC8240 Sandpoint platform (its
basically an 603e with some integrated peripherals) but this is my first
try at embedded linux devel. I have plenty of experience getting psos
and vxworks running on a few different processors, but I am unfamiliar
with the internals of how linux is booted.

I'm using ESTC's cheapo visionICE emulator solution, and would
appriciate any help with getting this thing up and running.

The main problems that I see are:

Its not CHRP or PREP.

No prom, so i need to:
Set up the memory map.
Program the EPIC.

Verify that the current serial drivers work with the Sandpoint's NS
PC87308.

Please email me directly, as I am not subscribed to this list, although
i do read it regularly on the linuxppc site.

nyet@nbase.com


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
