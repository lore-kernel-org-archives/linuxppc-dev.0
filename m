Date: Mon, 10 May 2004 23:33:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Efficient handling of RTP frames?
Message-ID: <20040510213336.GA4496@mars.ravnborg.org>
References: <20040510205808.GA4313@mars.ravnborg.org> <548E72DE-A2C7-11D8-95B9-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <548E72DE-A2C7-11D8-95B9-003065F9B7DC@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, May 10, 2004 at 05:16:40PM -0400, Dan Malek wrote:
>
> >Can anyone point in a direction where to find more information
> >about how to realise this in the most efficiet way?
>
> Without any more knowledge of your protocol details, you'll
> probably want to design the software to reduce the amount of
> interrupts.  There are buffer management concerns, such as
> alignment and location, but all of this depends on all of your
> system requirements outside of this processing.  Where is
> the RTP processing being done, on the 8xxx or the external device?

All (or most) procesing will be done outside the 82xx. The main
purpose of the 82xx will be to do a simple conversion to/from
RTP - since the external DSP will not use this format.

The alignment concerns you mention I expect can be addressed
we anyway have to develop a driver for the DSP connected to the FCC.
The buffer management needs a second thought.

But I still do not see how the two drivers can 'communicate',
or what other requirements is put on the driver that communicate
with the DSP.

	Sam

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
