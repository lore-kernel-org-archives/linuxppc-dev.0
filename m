Message-ID: <3FDDA552.7030007@intracom.gr>
Date: Mon, 15 Dec 2003 14:13:06 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>, org@stop.crashing.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 8xx drivers for 2.6
References: <20031211191854.GK23731@stop.crashing.org> <3FD8C932.60205@embeddededge.com> <20031211212529.GL23731@stop.crashing.org>
In-Reply-To: <20031211212529.GL23731@stop.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

>On Thu, Dec 11, 2003 at 02:44:50PM -0500, Dan Malek wrote:
>
>
>>Tom Rini wrote:
>>
>>
>>
>>>Ok. I've gone and ported the 8xx serial driver, and other misc 8xx
>>>things up to what 2.6 wants them to be, as well as a few of the
>>>simpler changes to head_8xx.S.
>>>
>>>
>>Thanks. So, does the kernel at least compile now? :-)
>>
>>
>
>Compiles, links, boots and happily dies inside of head_8xx.S :)
>
>
>
>>>...and in 2.6 having request_8xxirq becomes much uglier because of
>>>the irqreturn_t stuff
>>>
>>>
>>I'm finally going to update this. I've got a pretty good implemenation
>>of the cascaded controller stuff for the 8560, once I get this
>>debugged I'll port it here.
>>
>>
>
>Sounds like a plan.
>
>>>Dan, if you have _anything_ done for head_8xx.S can you please post
>>>it?
>>>
>>Yeah, maybe I can do some debug now, too.
>>
>
>Hopefully :)
>
>--
>Tom Rini
>http://gate.crashing.org/~trini/
>
>
>
>
>
That sounds nice.

Any chance to push the changes to the linuxppc-2.5 tree for us poor saps?
It doesn't have to work or anything, just give us something to work...

Regards

Pantelis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
