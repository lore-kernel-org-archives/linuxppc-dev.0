Message-Id: <200010060504.BAA22354@mal-ach.watson.ibm.com>
To: Robert Rati <arr060@email.mot.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Packing structures with gcc 
In-Reply-To: Message from Robert Rati <arr060@email.mot.com>
   of "Thu, 05 Oct 2000 18:15:13 CDT." <39DD0B81.1B174A4C@email.mot.com>
Date: Fri, 06 Oct 2000 01:04:46 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Have you looked at the "__attribute__ ((packed))" functionality in
the GCC documentation under C Extensions -- Variable Attributes?  That
should allow you to pack the members of the structure when it is
declared.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
