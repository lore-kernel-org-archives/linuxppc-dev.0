Message-Id: <199907071233.IAA10468@linus.mitre.org>
To: Scott Wood <scott@broadlink.com>
cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: RPX Lite kernel 
In-reply-to: Your message of "Tue, 06 Jul 1999 10:40:01 PDT."
             <37823F71.2BD5AF5F@broadlink.com>
Date: Wed, 07 Jul 1999 08:33:28 -0400
From: Charles Lepple <clepple@linus.mitre.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>[...] or written a utility to convert an ELF kernel into SREC format?  

Have you looked at objcopy? Unless I'm mistaken, you should be able to do a

  'objcopy -O srec vmlinux vmlinux.s19'

One issue that may crop up is the load address. objdump will let you look at
the ELF headers to make sure that you aren't trying to load the kernel at
at an address which does not map to RAM.

--Charles Lepple
clepple@mitre.org

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
