Message-Id: <9907191827.AA39168@marc.watson.ibm.com>
To: "Ringeman, Tim" <tim_ringeman@gilbarco.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with compiling and linking separately 
In-Reply-To: Message from "Ringeman, Tim" <tim_ringeman@gilbarco.com>
   of "Mon, 19 Jul 1999 14:07:34 EDT." <199907191808.OAA14312@hoover.gilbarco.com>
Date: Mon, 19 Jul 1999 14:27:44 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	You should be using the compiler, powerpc-linux-gcc, to perform
the link regardless of whether you are performing the link in a separate
step.  The link step involves more than just -lc.  You are omitting
important, additional commands to the linker by trying to invoke the
linker directly.  Either use GCC for the link or look at the verbose
output of GCC and learn the additional flags and libraries and object
files that must be passed to the linker.  For instance, you are omitting
the crt0 start files.

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
