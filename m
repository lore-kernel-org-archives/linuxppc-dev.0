Date: Mon, 15 Dec 2003 09:18:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Dan Malek <dan@embeddededge.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: 8xx drivers for 2.6
Message-ID: <20031215161815.GC23731@stop.crashing.org>
References: <20031211191854.GK23731@stop.crashing.org> <3FD8C932.60205@embeddededge.com> <20031211212529.GL23731@stop.crashing.org> <3FDDA552.7030007@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FDDA552.7030007@intracom.gr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 15, 2003 at 02:13:06PM +0200, Pantelis Antoniou wrote:
> Tom Rini wrote:
> >On Thu, Dec 11, 2003 at 02:44:50PM -0500, Dan Malek wrote:
> >>Tom Rini wrote:
> >>
> >>>Ok. I've gone and ported the 8xx serial driver, and other misc 8xx
> >>>things up to what 2.6 wants them to be, as well as a few of the
> >>>simpler changes to head_8xx.S.
> >>>
> >>>
> >>Thanks. So, does the kernel at least compile now? :-)
> >>
> >
> >Compiles, links, boots and happily dies inside of head_8xx.S :)
> >
> >>>...and in 2.6 having request_8xxirq becomes much uglier because of
> >>>the irqreturn_t stuff
> >>>
> >>>
> >>I'm finally going to update this. I've got a pretty good implemenation
> >>of the cascaded controller stuff for the 8560, once I get this
> >>debugged I'll port it here.
> >
> >Sounds like a plan.
> >
> >>>Dan, if you have _anything_ done for head_8xx.S can you please post
> >>>it?
> >>>
> >>Yeah, maybe I can do some debug now, too.
> >>
> >
> >Hopefully :)
>
> That sounds nice.
>
> Any chance to push the changes to the linuxppc-2.5 tree for us poor saps?
> It doesn't have to work or anything, just give us something to work...

Sure, done.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
