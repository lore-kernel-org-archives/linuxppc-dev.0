Date: Thu, 19 Apr 2001 12:44:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: Steven Hein <ssh@sgi.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 RTC support
Message-ID: <20010419124455.O13403@opus.bloom.county>
References: <3ADE0222.BF7F539C@sgi.com> <3ADE0501.321052F9@mvista.com> <3ADF1377.72242D3B@sgi.com> <3ADF3970.C015DB5D@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ADF3970.C015DB5D@mvista.com>; from dan@mvista.com on Thu, Apr 19, 2001 at 03:16:00PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 19, 2001 at 03:16:00PM -0400, Dan Malek wrote:
>
> Steven Hein wrote:
>
> > My problem is this:   when I set the date via the "date --set"
> > command (which calls stime()) or by calling settimeofday() directly,
> > it doesn't result in the 860's RTC being updated.
>
> Ahh, OK.  I'll take a look at this.  I thought it used to work in
> older kernels.  It's on my list (or if someone else wants to take
> a look and send a patch ...... :-).

I think I understand the question/problem too.  We'll see what else I've
got to work on as well. :)  Just checking, Steven have you tried to
enable the "PPC_RTC" driver and gotten this same incorrect behavior?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
