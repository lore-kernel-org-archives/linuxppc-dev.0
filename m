Message-Id: <200110251627.MAA26720@makai.watson.ibm.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "KOBAYASHI R. Taizo" <tkoba@ike-dyn.ritsumei.ac.jp>,
	jeglin@4pi.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.13-pre5 crash when mounting proc 
In-Reply-To: Message from Tom Rini <trini@kernel.crashing.org>
   of "Thu, 25 Oct 2001 08:30:32 PDT." <20011025083032.A29107@cpe-24-221-152-185.az.sprintbbd.net>
Date: Thu, 25 Oct 2001 12:27:36 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Tom Rini writes:

Tom> Um.  Is that _all_ that changed?  That really shouldn't have any effect
Tom> at all...  What compiler/binutils combo is this?

	It looks like the incorrect version has a continuation character
to a blank line instead of a continuation returning to .text section.
That definitely could cause problems.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
