In-Reply-To: <Pine.LNX.4.61.0408260822060.19804@chef.linux-wlan.com>
References: <Pine.LNX.4.61.0408251615540.9890@chef.linux-wlan.com> <cgk0lp$5dk$1@sea.gmane.org> <Pine.LNX.4.61.0408260822060.19804@chef.linux-wlan.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8F645223-F76B-11D8-89B4-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	=?ISO-8859-1?Q?Stefan_St=FCrke?= <sst@pandatel.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [SPAM] Re: m8xx hang in reboot
Date: Thu, 26 Aug 2004 10:23:54 -0400
To: "Mark S. Mathews" <mark@linux-wlan.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 26, 2004, at 8:28 AM, Mark S. Mathews wrote:

> One item of info that I had left out of the original post (because I
> hadn't verified 100% that this was truly part of the issue):
>   The "certain circumstances" prior to the reboot failure are:
>     1) we've just completed an unlock/erase/write on one of our flash
>        partitions.

Oh Geeze.....yeah, that could be a problem :-)

>     2) the wlan device that's attached to the pcmcia interface was
>        previously in use.

Can you test these independently to see which is causing the
trouble?  I'm also guessing it's number 1.

> If the wlan device was not in use or if we don't do the flash
> unlock/erase/write, then the reboot works just fine.  Strange
> combination
> of factors.

Both of these make sense.  After you are done writing the flash,
do something to read  it, so it returns to that state.  You may
need to shut down the wlan before rebooting if that is causing
the trouble.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
