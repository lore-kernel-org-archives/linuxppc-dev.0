Message-ID: <3957DEFF.9064056E@netx4.com>
Date: Mon, 26 Jun 2000 18:53:51 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Whitney, John" <johnw@aiinet.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Image caching/swap bugs
References: <7283DE19D141D111AD0E00A0C95B195502C5F5F2@mail2.aiinet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Whitney, John wrote:

> I have a 2.2.15 kernel running on a proprietary board


You shouldn't be using 2.2.15 with 8xx.  I am not going to discuss
the history right now, but the only reliable verion of 2.2.xx Linux
is the 2.2.13 version on the MontaVista Web site (www.mvista.com).
This is the only one I am maintaining, have patched and verified it
works.  I am updating this to 2.2.14, only to match the rest of
the MontaVista packages so it can be built and tested along with
other platforms.  If there are some specific features of later
releases you think you need (and I don't know of any that affect 8xx),
please let me know.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
