Message-ID: <3FE6B2A5.2020609@embeddededge.com>
Date: Mon, 22 Dec 2003 04:00:21 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: Tom Rini <trini@kernel.crashing.org>, org@stop.crashing.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 8xx drivers for 2.6
References: <20031211191854.GK23731@stop.crashing.org> <16358.4872.857438.957341@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> Gaahhhh, I thought we had got rid of request_8xxirq.  I don't want to
> see it come back.  And this sort of thing is just bad.

I don't know why in the hell this has irritated you so badly.
It's 10 lines of code to allow people to use those legacy PC devices
on boards like the MBX860 have have an 8259 controller.

In any case, since the 2.4 was screwed up so badly when it was
removed there, I have removed it from 2.6. I'm just building various
configurations right now to ensure I didn't break some non-8xx stuff
in the process.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
