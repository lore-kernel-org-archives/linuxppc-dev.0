Message-Id: <200101210230.VAA37976@mal-ach.watson.ibm.com>
To: khendricks@ivey.uwo.ca
cc: Andy Johnson <andyj@mc.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Issue with small struct return values 
In-Reply-To: Message from "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
   of "Sat, 20 Jan 2001 21:19:31 EST." <01012021193101.13943@localhost>
Date: Sat, 20 Jan 2001 21:30:38 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Kevin B Hendricks" writes:

Kevin> That wasn't what I asked.  I asked what the process would be for making this
Kevin> decision (if it has already not been made).

	Actually, it is the answer.  The decision would be made by the
developers if there was a good argument for it and/or a proposed
implementation.  The GCC SC might make the final decision, guided by the
public discussion.  The main issue with GCC extensions is that they be
well-defined so that we avoid the repeat of problems that have occurred
with previous extensions.

	What ever is proposed will not be included in GCC 3.0 because that
release has been frozen with respect to new features.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
