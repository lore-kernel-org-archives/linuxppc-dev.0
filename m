Message-ID: <3FD8C932.60205@embeddededge.com>
Date: Thu, 11 Dec 2003 14:44:50 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: org@stop.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 8xx drivers for 2.6
References: <20031211191854.GK23731@stop.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> Ok. I've gone and ported the 8xx serial driver, and other misc 8xx
> things up to what 2.6 wants them to be, as well as a few of the
> simpler changes to head_8xx.S.

Thanks.  So, does the kernel at least compile now?  :-)

> ...and in 2.6 having request_8xxirq becomes much uglier because of the
> irqreturn_t stuff

I'm finally going to update this.  I've got a pretty good implemenation
of the cascaded controller stuff for the 8560, once I get this debugged
I'll port it here.

> Dan, if you have _anything_ done for head_8xx.S can you please post
> it?

Yeah, maybe I can do some debug now, too.

Thanks.

	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
