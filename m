Message-Id: <v03130301b3f246350c70@[192.168.1.1]>
In-Reply-To: <199908310616.IAA00299@piglet.cpu.lu>
References: <v03130301b3f116a864e2@[192.168.1.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 31 Aug 1999 21:59:31 -0500
To: mlan@cpu.lu
From: "David D. Kilzer" <ddkilzer@computer.org>
Subject: Re: SMP support for Daystar 604e 200MHz dual-processor card
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

>> Serial driver version 4.27 with no serial options enabled
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> Machine check in kernel mode.
>
>This might be a shot in the dark, but I never heard of anyone
>successfully compiling in standard serial support on the PowerMacs. I
>tried it myself; I would get a panic upon initializing the serial
>driver (exactly like above..).
>
>So you might want to disable standard serial suport, and recompile...

Yes!  Thanks for all the help!  This was the problem.  I removed
CONFIG_SERIAL and it booted!

Unfortunately, I still get a "Processor 1 stuck." message on boot, which
apparently makes it absent from /proc/cpuinfo as well.  This is booting
from the BootX application in Mac OS (with or without extensions loaded).

I haven't tried booting from OF or with the BootX extension yet.

Thanks again for all the help!!  (Anyone get 2.3.x to boot with SMP? :^)

Dave


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
