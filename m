Message-Id: <199908270548.HAA00486@piglet.cpu.lu>
Date: Fri, 27 Aug 1999 07:48:26 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: no more processes crash
To: jackal@aol.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.SGI.4.00.9908261904190.13884-100000@osiris.office.aol.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  26 Aug, this message from brad allison echoed through cyberspace:
> This is a bad bug/crash.  I suddenly am in a state of "No more processes".
> 
> I'm not running much.  Just about 10 aterms, netscape and aim.
> 
[snip]
> Last thing I did was started a compile of kerberos.  So the last command I
> ran was "make".

This might not be a Linux bug, but rather a Makefile bug in kerberos.
I've had this before, endless loops in a Makefile, so make restarts
itself all over again, until... you found the answer ;-).

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
