MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Poor 8260 FCC Ethernet performance 
Date: Thu, 10 Jun 2004 14:26:09 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DAFB@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Dan Malek [mailto:dan@embeddededge.com]
> Sent: Thursday, June 10, 2004 12:57
> What?  No, no no.

> There isn't any performance problem  with this driver if your
> hardware is working properly.  I cant' believe this change
> would have done anything except eventually causing the system to fail.

It did fail after a while. Had to move the BD's back into host memory to
get it to work correctly again.
Strage thing is that of the two CPU's on my board, it worked on one
(sort of) , and failed immediately on the other...

>
> What kernel are you using?

2.6.5


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
