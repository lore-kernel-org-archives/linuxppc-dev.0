To: Christoph Hellwig <hch@lst.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC5200 Patches 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Nov 2003 12:53:15 +0100."
             <20031120115315.GA7411@lst.de>
Date: Thu, 20 Nov 2003 13:10:32 +0100
Message-Id: <20031120121037.90F93C5F5F@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20031120115315.GA7411@lst.de> you wrote:
>
> Umm, the code needs a rewrite before it's suitable for mainline.  In

Are you volunteering? ;-)

> it's current state is just bogus utter crap.  The bestcomm API needs
> to go away and the dma engine used directly.

It would be nice if you explained your reasons for such a statement.


I agree that there is better and more efficient code than the current
bescomm API. On the other hand, we have  already  seen  what  happens
when  you  do not use the official API and try to implement your own,
more efficient access routines. It's a maintenance nightmare.

Remember that this is _microcode_  which  is  not  finished  at  all.
Especially  in the near future changes and new versions from Motorola
are more than likely. Using the official Motorola  API  may  be  less
efficient  than what you can get with a different implementation, but
at least it will keep the existing code running.

If you bypass the official API, each new microcode version will break
your code. Been there before. This ain't fun.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Parkinson's Law:  Work expands to fill the time alloted it.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
