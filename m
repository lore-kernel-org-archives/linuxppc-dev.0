Message-ID: <39BEE4B4.4CC86250@mvista.com>
Date: Tue, 12 Sep 2000 22:21:40 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Julia Elbert <jelbert@enerdyne.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: no scc_hdlc struct in commproc.h
References: <67505026E29DD311A9AA00508B7315F31956EC@EXCHANGE>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Julia Elbert wrote:

> I did not find a scc_hdlc structure like scc_enet and scc_uart in
> commproc.h.

I don't think anyone has submitted any source patches to provide it.
There has been some discussion in the past......

> .... Do I just need to make one similar to scc_enet and modify it
> according to p.24-4 in the 860 book?

That would be great.  If you would like to submit it as a patch someday,
that would be even greater :-).  What are you connecting at each end
of the port?  NMSI, TDM, custom software?

Another part of your project will be writing a driver.  In the past,
the accepted suggestion was to not modify the uart driver, as that
is a _uart_ driver, not an SCC driver.  You can use that as a model
to create, say, hdlc.c......Then just ensure you don't try to configure
the SCC in both places (and there  may need to be a little knowledge
about each one in every driver).

> Thank you in advance.

Have fun!


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
