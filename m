Message-Id: <199907081849.NAA17198@www2.tuckeris.com>
Date: Thu, 08 Jul 1999 13:37:36 -0500
Subject: Re: PowerPC assembly question
From: "Charles A. Jolley" <charles.jolley@zeratec.com>
To: Charles Lepple <clepple@mitre.org>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


There are two main ABI's that I have consulted in the past regarding how 
Linux handles linking, etc. on the PowerPC.  The primary one is the
PowerOpen ABI, which describes many of the general register usage
conventions.  The other is the "System V ABI, PowerPC Processor Supplement",
published by SunSoft.  This primarily describes how PowerPC images are held
in ELF files.  I have both of these plus some additional helper docs in PDF
format which I use for reference here, but I know they are also available on
the web somewhere and there are probably some more up-to-date versions.
(Mine were released in 1994).

I can send them if needed...the copyrights don't prohibit redistribution...
however I seem to remember getting all of these from either IBM or
Motorola's PowerPC site so you may want to check there for newer versions
first.

Cheers,
-Charles

----------
>From: Charles Lepple <clepple@mitre.org>
>To: linuxppc-dev@lists.linuxppc.org
>Subject: PowerPC assembly question
>Date: Thu, Jul 8, 1999, 12:39 PM
>

>
> Hope this isn't too far off topic.
>
> I've been poking around with some disassembled C code, and I'm wondering
> if there is a source of documentation on register usage guidelines
> (maybe an ABI? I'm just not used to this concept of passing arguments in
> registers as opposed to the stack). Any help would be appreciated.
>
> --Charles Lepple
> clepple@mitre.org
> 

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
