Message-ID: <001a01c48abe$0fccb5f0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>
References: <Pine.LNX.4.60.0408241141110.6489@localhost.localdomain> <000f01c48a95$e18e5c20$0301a8c0@chuck2> <FE902A72-F6AB-11D8-918A-003065F9B7DC@embeddededge.com>
Subject: Re: value of XIP?  and whether it works with 2.6 kernel?
Date: Wed, 25 Aug 2004 12:10:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> On Aug 25, 2004, at 7:22 AM, Mark Chambers wrote:
>
> > The main value, I believe, is as part of a rapid boot setup - you can
> > avoid the decompress and copy phase.
>

Dan Malek responded:

> The XIP has little effect on this.  Wolfgang hit the important points.
> I originally did XIP on the 8xx many years ago for an embedded
> appliance that was DRAM challenged.  It saved a little memory,
> but along with it came the pinned TLB which helped a little with
> performance.
>

I guess I wasn't basing my comment exclusively on 8xx, but thinking
more of the general linux quick boot work being done, as in this
paper from the linux 2004 symposium (see section 4):
http://www.finux.org/Reprints/Reprint-Bird-OLS2004.pdf
So, in other words, maybe XIP will come back again?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
