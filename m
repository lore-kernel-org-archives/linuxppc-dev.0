In-Reply-To: <20040510205808.GA4313@mars.ravnborg.org>
References: <20040510205808.GA4313@mars.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <548E72DE-A2C7-11D8-95B9-003065F9B7DC@embeddededge.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Efficient handling of RTP frames?
Date: Mon, 10 May 2004 17:16:40 -0400
To: Sam Ravnborg <sam@ravnborg.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On May 10, 2004, at 4:58 PM, Sam Ravnborg wrote:


> Does this sound like a dead-end doing this in Linux?

No problem.  It will work fine.  Depending upon the processing
you are doing, you could probably do it with an 8xx.

> Can anyone point in a direction where to find more information
> about how to realise this in the most efficiet way?

Without any more knowledge of your protocol details, you'll
probably want to design the software to reduce the amount of
interrupts.  There are buffer management concerns, such as
alignment and location, but all of this depends on all of your
system requirements outside of this processing.  Where is
the RTP processing being done, on the 8xxx or the external device?

All of this is well within the capabilities of the processor and Linux.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
