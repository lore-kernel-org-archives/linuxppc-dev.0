Message-ID: <38D2A7B4.A74AF086@embeddededge.com>
Date: Fri, 17 Mar 2000 16:46:28 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Richard Hendricks <ra6353@email.sps.mot.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What is the catch with IDMA on MPC860?
References: <38D27077.C11A3B28@embeddededge.com> <38D2A182.DA3DA70E@email.sps.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Richard Hendricks wrote:
>
> Ah, but there's an assumption you're making Dan, and that's the IDMA
> was added for the 860.

Geeze, I guess my couple of years of technical writing classes were
a waste of time.  Where did it appear I was making an assumption?

I said:

	1.  The 860 is a killer communication processor
	2.  The IDMA is a feature that requires system design trade offs
	3.  If IDMA wasn't present, people would likely request it


> ....  It was really added for camera customers using
> the MPC821/MPC823.

OK, but we weren't talking about 821 or 823.  There is a wide range of
features available in the 8xx family, and unfortunately you can't
get everything all of the time.  The IDMA on the 860 falls into
this category.

My original response long ago was to ensure people consider the system
design, and I attempted to include some supporting detail.  This has
been turned into "performance sucks" and "Dan is making assumptions."
Neither is true.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
