Message-Id: <200101210041.TAA25654@mal-ach.watson.ibm.com>
To: khendricks@ivey.uwo.ca
cc: Andy Johnson <andyj@mc.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Issue with small struct return values 
In-Reply-To: Message from "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
   of "Sat, 20 Jan 2001 19:16:56 EST." <01012019165601.13876@localhost>
Date: Sat, 20 Jan 2001 19:41:52 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	GCC does not have control over how varargs are suppose to be
accessed -- that is part of the C language spec.

	Proposing an extension to GCC is a lot more difficult than having
GCC follow the ABI as written.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
