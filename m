Message-ID: <XFMail.990301222929.hcaley@loomer.com>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Date: Mon, 01 Mar 1999 22:29:29 -0500 (EST)
From: Batmensch <hcaley@loomer.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: strdup and pre-R5
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm having a problem building OpenLdap 1.2 on a pre-R5 installation; the error
seems to be with strdup(); the make complains :

"In file included from args.c:22:
../../include/ac/string.h:49 macro `strdup' using without args"

I've been able to build it without error on both LinuxPPC 4 and Linux X86. 
Also the build of 1.0.2 that is included with the R5 distribution seems to work
properly.

Anything i can do about this?

BTW, I'm using the late February build of R5, and a 2.2.2 kernel I built from
CVS at Samba.

Hugh




----------------------------------
E-Mail: Batmensch <hcaley@loomer.com>
Date: 01-Mar-99
Time: 22:19:28

This message was sent by XFMail
----------------------------------

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
