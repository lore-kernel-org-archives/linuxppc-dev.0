From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: David Edelsohn <dje@watson.ibm.com>, khendricks@ivey.uwo.ca
Subject: Re: Issue with small struct return values
Date: Sat, 20 Jan 2001 20:52:39 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Andy Johnson <andyj@mc.com>, linuxppc-dev@lists.linuxppc.org
References: <200101210041.TAA25654@mal-ach.watson.ibm.com>
In-Reply-To: <200101210041.TAA25654@mal-ach.watson.ibm.com>
MIME-Version: 1.0
Message-Id: <01012020523900.13943@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi David,

> 	Proposing an extension to GCC is a lot more difficult than having
> GCC follow the ABI as written.

Whose decision will this be?  Is this going to be a community based decision
or will gcc decide to do this unlaterally with or without the community's
support?

What voice should the currently shipping distributions have in this?

I saw no discussion on gcc-bugs about this issue (and was not privy to your
and Geoff's previuous discussion with Andy about this issue).

That is why I responded to Andy in the first place.

What process, if any exists for this decision to be made?

I assume you wanted a community based decision since you asked Andy to cc
this to the linuxppc dev list.

Also, on a more technical note, how many <= 8 byte structures are there in
actual use anyway?  I would guess that most uninos are less than or eqaul to
8 bytes and so returning unions would change.  So according to the abi, would
we would passing a union in to a function via a pointer but returning one in
registers?

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
