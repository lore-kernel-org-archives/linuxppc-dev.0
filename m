Message-Id: <200008111826.OAA24884@mal-ach.watson.ibm.com>
To: "David L. Thompson" <dthompsn@cs.umt.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: char is not signed char 
In-Reply-To: Message from "David L. Thompson" <dthompsn@cs.umt.edu>
   of "Fri, 11 Aug 2000 12:12:15 MDT." <p04320418b5b9f21900aa@[192.168.1.1]>
Date: Fri, 11 Aug 2000 14:26:41 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "David L Thompson" writes:

David> Has anybody else noticed that char is not signed char but unsigend
David> char? If I write the following:

	Yes, this is up to the implementation to decide.  For PowerPC,
unsigned char is more efficient and may even be defined by the ABI.  You
can invoke GCC with -fsigned-char if you require the other behavior.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
