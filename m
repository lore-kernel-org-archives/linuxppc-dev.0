Date: Mon, 30 Jul 2001 19:04:26 -0700
From: David Schleef <ds@schleef.org>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: Bastien Nocera <hadess@hadess.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Clock problem
Message-ID: <20010730190425.A21522@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
References: <20010724015531.516c9985.jpgarcia@execpc.com> <3B63877E.9060001@hadess.net> <20010729010905.3faf9642.jpgarcia@execpc.com> <3B648DC5.9050009@hadess.net> <20010729184526.B19846@localhost.localdomain> <3B64935B.6030309@hadess.net> <3B65885F.C3683087@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B65885F.C3683087@wanadoo.fr>; from costabel@wanadoo.fr on Mon, Jul 30, 2001 at 06:16:32PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 30, 2001 at 06:16:32PM +0200, Martin Costabel wrote:
>
> Bastien Nocera wrote:
>
> > mean ? not really, goes back to 1933 after each reboot...
>
> You don't mean 1903? 'Cause that's what I get (December 31, 1903) after
> each try to boot either 2.4.7-ben0 or 2.4.8-pre1(kernel.org) on my
> iBook1-FW. 2.4.7-ben0 goes up to ..mounting local file systems.. and
> then dumps me into xmon from a process ksoftirqd_CPU0 or something
> similar. At leaving xmon, it shuts down hard, the PRAM is zapped, and it
> is Dec 31, 1903. This is worse than taking out the battery, which gives
> Jan 1st, 1904.


1933 is significant because it is 2^31 seconds in the past.
Apparently, there is a difference in the way that stime() and
settimeofday() operate, since the date command works correctly
when the year is set to 1903 (and uses stime()), whereas ntpdate
does not.  (ntpdate uses settimeofday()).  Then again, it might
just be a bug in ntpdate.



dave...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
