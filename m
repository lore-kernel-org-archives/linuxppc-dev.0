In-Reply-To: <1093483666.3777.1579.camel@imladris.demon.co.uk>
References: <Pine.LNX.4.60.0408241141110.6489@localhost.localdomain> <000f01c48a95$e18e5c20$0301a8c0@chuck2> <FE902A72-F6AB-11D8-918A-003065F9B7DC@embeddededge.com> <001a01c48abe$0fccb5f0$0301a8c0@chuck2> <60394D06-F6B8-11D8-918A-003065F9B7DC@embeddededge.com> <1093483666.3777.1579.camel@imladris.demon.co.uk>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <54EAA5E6-F712-11D8-89B4-003065F9B7DC@embeddededge.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Mark Chambers <markc@mail.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: value of XIP?  and whether it works with 2.6 kernel?
Date: Wed, 25 Aug 2004 23:45:11 -0400
To: David Woodhouse <dwmw2@infradead.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 25, 2004, at 9:27 PM, David Woodhouse wrote:

> It's a little bit harder than that if you want to actually write to the
> same flash chip you're running from. :)

Many of the "modern" parts will let you do that.  Load a buffer,
start the update, come back later to check it.  The MTD may
need some updates to do that, but I'm sure you're up for it :-)
Software upgrade of embedded systems is a totally different
discussion.  Having multiple images that you need to choose
based upon validity, dates, failure to boot previously, etc. are
all things that significantly increase the boot time. :-)

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
