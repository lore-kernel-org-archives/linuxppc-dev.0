Date: Wed, 21 Apr 1999 10:55:07 -0500 (CDT)
From: Dave Weis <djweis@plconline.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: couple questions on bootloaders
Message-ID: <Pine.LNX.3.95.990421103051.9340F-100000@catbert.desm.plconline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



hello!

i was looking thru identify_machine in setup.c and had a question about
the handling of residual data. on my rs6000, there is a massive structure
with pointers to other structures. the book says that a warm boot reuses
that structure so i can't overwrite it. is there a way that i can prevent
the kernel from touching the area? alternatively, does anyone know if that
structure will be located in the available memory space or in the
architected system memory from 0xff000000 to 0xffffffff? 
also, what instructions would i use to write an arbitrary byte to memory
locate 0xff700300?


thanks for the help!

dave


-- 
David Weis                | 10520 New York Ave, Des Moines, IA 50322
djweis@plconline.com      | Voice 515-278-0133 Ext 231

When they took the Fourth Amendment, I was quiet because I didn't deal drugs.
When they took the Sixth Amendment, I was quiet because I was innocent.
When they took the Second Amendment, I was quiet because I didn't own a gun.
Now they've taken the First Amendment and I can't say anything.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
