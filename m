Message-ID: <3AE05AE5.1AA8DFA2@sgi.com>
Date: Fri, 20 Apr 2001 10:51:01 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 RTC support
References: <3ADE0222.BF7F539C@sgi.com> <3ADE0501.321052F9@mvista.com> <3ADF1377.72242D3B@sgi.com> <3ADF3970.C015DB5D@mvista.com> <20010419124455.O13403@opus.bloom.county> <3ADF426A.5E9C0EBD@sgi.com> <20010419130842.Q13403@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:
>
>
> Okay, it doesn't _quite_ work (hwclock will oops) but hopefully it
> won't be too hard to track down.  I'll try and get to it this afternoon
> or tomorrow, or when time permits (!+@$*ing classes).  Patches greatly
> appreciated. :)
>

I don't have a patch put together yet, but I found the problem:
m8xx_get_rtc_time is an __init function in the 2.4.x tree.
Remove the __init and it works great!

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
