From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: David Edelsohn <dje@watson.ibm.com>, khendricks@ivey.uwo.ca
Subject: Re: Issue with small struct return values
Date: Sat, 20 Jan 2001 19:16:56 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Andy Johnson <andyj@mc.com>, linuxppc-dev@lists.linuxppc.org
References: <200101202137.QAA22694@mal-ach.watson.ibm.com>
In-Reply-To: <200101202137.QAA22694@mal-ach.watson.ibm.com>
MIME-Version: 1.0
Message-Id: <01012019165601.13876@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> 	GCC 3.0 (whose major number implies breaking backward
> compatibility) seems like a good opportunity to correct this mistake.

>From what I understand, GCC 3.0 would only have broken things for C++ based
items and not for everything.

So what you are proposing is a very major change!

I think during such a change, one other issue really should be addressed
(and I am sure there are others)

Given the ppc sys v abi uniqueness in handling varargs, there is no
cross-platform solution for passing the address of a va_list or dereferencing
that same beast.  Right now real programs do this (the JDK for example) and
there are no macros (like VA_COPY) that hide the differences.  This
introduces bugs that are very hard to track down.

Can you push something (a MACRO of some sort) like that through during the
GCC change David?

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
