Message-Id: <200001201826.NAA25092@mal-ach.watson.ibm.com>
To: khendricks@ivey.uwo.ca
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
In-Reply-To: Message from Kevin Hendricks <khendricks@ivey.uwo.ca>
   of "Thu, 20 Jan 2000 13:12:49 EST." <00012013133502.00819@localhost.localdomain>
Date: Thu, 20 Jan 2000 13:26:48 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	The "b" constraint should be associated with "base_addr", not with
"regindex":

	asm("stwbrx %0,%1,%2": : "r"(regdata), "r"(regindex), "b"(base_addr));

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
