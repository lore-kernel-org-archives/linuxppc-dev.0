Date: Mon, 22 Mar 1999 13:01:32 +0100 (MET)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: Michael Lundkvist <ml@epact.se>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME 2306 almost up and running
In-Reply-To: <qpzp55dbru.fsf@erbium.epact.se>
Message-ID: <Pine.SO4.4.05.9903221251590.18896-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 22 Mar 1999, Michael Lundkvist wrote:

> Could it be a problem with library versions? Both /bin/sh and
> /sbin/init are dynamically linked against libc and I remeber having
> problems when I accidently used a libc from R5 with a binary from R4.

 All files I downloaded are from an R4. However, I have some new info.
 I started rpc.nfsd with the '-l' option. And this is what shows up in
 /var/adm/messages :

 ``Mar 22 12:53:26 elpc6 nfsd[5351]: 143.169.5.29 < /export/sbin/init
   Mar 22 12:53:26 elpc6 nfsd[5351]: 143.169.5.29 < /export/bin/bash''

 So, the kernel seems to be requesting those files (and receiving them ?).
 You could be right about the dynamic libraries. But, before I reinstall
 the entire root fs, I want to make sure *that* is the problem. Does
 any of you kind people have a statically linked program I could use to
 test, e.g. a Hello World program ?

 BTW, the 'file' commando recognizes PPC binaries. But can it make a 
 distinction between statically and dynamically linked binaries (I know
 it can for i386 arch) ? E.g., when I do a 'file' on my PPC init :

 ``sbin/init: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1''

 and on my i386 /sbin/init :

 ``/sbin/init: ELF 32-bit LSB executable, Intel 80386, version 1,
               statically linked, stripped''

 Thank you,

+-----------------------------------------------------------------+
|   David 'Septimus' De Ridder   | "Never underestimate the       |  
|                                |  power of the soul unleashed." |
| <david.de.ridder@bitsmart.com> |   - 'Essence Flare', M:TG      |
+-----------------------------------------------------------------+

--
"Every dog has its day, and today's mine."
 Terry Borer after winning the Masters finals at the New York M:TG Pro Tour 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
