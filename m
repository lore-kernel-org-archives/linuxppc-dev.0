Message-Id: <199908041025.MAA00244@piglet.cpu.lu>
Date: Wed, 4 Aug 1999 12:25:09 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: OF booting of G3-upgraded 7600?
To: linuxppc-dev@lists.linuxppc.org
cc: linux-pmac@samba.anu.edu.au
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

More details on my OF booting problems:

On   2 Aug, this message from mlan@cpu.lu echoed through cyberspace:
> Anybody have any idea why a 7600 upgraded with a littleJoe G3 card
> can't boot through OF? I always get a 'Default Catch'.

The error messages are:

- on boot:

Default Catch!, code=FFF00400

- on subsequent 'boot' commands:

0> boot Claim failed
 ok
0>

I do have a boot-command setting thaht makes sure the disk has had time
to spin up, and retries loading multiple times.

Any thoughts? Anyone able to decode the Default Catch?

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
