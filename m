Message-Id: <200104111456.KAA15100@makai.watson.ibm.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: another difference in gcc (2v) ? 
In-Reply-To: Message from "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
   of "Wed, 11 Apr 2001 10:15:45 EDT." <200104111415.f3BEFkQ28728@ashley.ivey.uwo.ca>
Date: Wed, 11 Apr 2001 10:56:06 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	"subf" and "srawi" only set condition codes if the "Rc" bit is
set, e.g. "subf." and "srawi."

	Given the two sequences of code you have sent, I think the problem
is tht the exception table is being initialized with incorrect labels.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
