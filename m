Message-Id: <199908030535.HAA00313@piglet.cpu.lu>
Date: Tue, 3 Aug 1999 07:35:22 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: OF booting of G3-upgraded 7600?
To: jkl@teleport.com
cc: linuxppc-dev@lists.linuxppc.org, linux-pmac@samba.anu.edu.au
In-Reply-To: <Pine.GSO.4.10.9908021936020.3756-100000@user2.teleport.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On   2 Aug, this message from Jeffrey Karl Lassahn echoed through cyberspace:
> One simple thing that bit me is that the machine can try to boot before
> the hard drive hs spun up.  This gives the default catch you're seeing,
> and it depends on CPU speed.
> 
> I fixed it with an OpenFirmware change that I haven't bothered to fully
> understand, but which seems to work great.  That is:
> set 
> boot-command
> to
> begin ['] boot catch 1000 ms cr again

I already have this in my bootvars. I will check again, but at first
glance, I don't think this will help.

Thanks anyway ;-)

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
