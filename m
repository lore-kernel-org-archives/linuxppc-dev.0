Message-ID: <3ADF3970.C015DB5D@mvista.com>
Date: Thu, 19 Apr 2001 15:16:00 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Steven Hein <ssh@sgi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 RTC support
References: <3ADE0222.BF7F539C@sgi.com> <3ADE0501.321052F9@mvista.com> <3ADF1377.72242D3B@sgi.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Hein wrote:

> My problem is this:   when I set the date via the "date --set"
> command (which calls stime()) or by calling settimeofday() directly,
> it doesn't result in the 860's RTC being updated.


Ahh, OK.  I'll take a look at this.  I thought it used to work in
older kernels.  It's on my list (or if someone else wants to take
a look and send a patch ...... :-).

> I know I'm missing something, as it sounds like this works for others,

As I recall, there are events that occur to update the RTC from
the kernel's notion of time, and one used to be some timeout.  Perhaps
after you set the time, if you wait for a while it may update the RTC.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
