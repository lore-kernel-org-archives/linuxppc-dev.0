Date: Fri, 23 Apr 1999 12:32:17 +0200 (MET DST)
From: David De Ridder <s970707@uia.ua.ac.be>
Reply-To: David De Ridder <david.de.ridder@bitsmart.com>
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: tulip.c v0.91 does not compile under 2.2.6
Message-ID: <Pine.SO4.4.05.9904231226200.14515-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well,

the subject says it all. I tried this because some people would like
to have Tulip support instead of de4x5 on their VME board. 
There seems to be a conflict with include files (linux/string.h ?). I
noticed the order of include files changed a bit sine 0.89, but I'm
no Tulip driver expert, so I can't say why (or why compilation fails).

However, it DOES compile on a 2.0.36.

The web page states that it is supposed to compile under 2.1.x as
well, but there's nothing on 2.2.x. Does this mean : "no, it does
NOT compile under 2.2", or "we haven't got a clue whether it compiles
on 2.2" ?

It was worth a try.

+-----------------------------------------------------------------+
   David 'Septimus' De Ridder     <david.de.ridder@bitsmart.com>

"Blow the world apart with a press of a button
 we all say it shouldn't but we know it will happen.
 Again and again, like the rain and the ark :
 almost forever, eternally dark."
 - Anne Clark
+-----------------------------------------------------------------+


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
