Message-ID: <3ADF4386.3DCF6725@sgi.com>
Date: Thu, 19 Apr 2001 14:59:02 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 RTC support
References: <3ADE0222.BF7F539C@sgi.com> <3ADE0501.321052F9@mvista.com> <3ADF1377.72242D3B@sgi.com> <3ADF3970.C015DB5D@mvista.com> <3ADF3EA4.20802034@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> Well, hell.....what I used to do is now considered "userland
> business."  I guess the right thing to do is create a /dev/rtc
> that will manage the MPC8xx RTC.  Sorry I missed this as the
> kernel evolved.
>
I know this isn't under your control, but......

If this is the case (that setting the RTC is properly done through
/dev/rtc using hwclock, etc.), then doing a "date --set" no longer
sets the RTC, correct?  And it will never cause the RTC to be set?

.....Seems to me that separating the setting of the RTC from setting
the kernel/system time is a Bad Idea.....There's probably more to it
than that, or maybe "date --set" isn't considered a proper way to
manipulate the system clock anymore (maybe it never was   :).

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
