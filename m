Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 1AE3668615
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Oct 2005 06:37:36 +1000 (EST)
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Oct 2005 12:57:22 +0200."
	<200510281257.22650.david.jander@protonic.nl>
Date: Fri, 28 Oct 2005 22:37:27 +0200
Sender: wd@denx.de
Message-Id: <20051028203727.76C2C353E3E@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel 2.6 on MPC8xx performance trouble... 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200510281257.22650.david.jander@protonic.nl> you wrote:
>
> > What is 'a' and 'b'? The only other explanation I can see is that your
> > "Do something" is more memory heavy than you think - array calculations?
> > (Cache problems should probably give a worse result, but you could check
> > that those config registers are the same).
> 
> They are just integers with fixed start values. These are in the loop, so it's 
> not an empty loop and hopefully the compiler won't out-optimize it so easily 
> (that is of course without specifying any optimization flags). Please don't 
> tell me it's a lousy benchmark, because I already know that! Be it as lousy 
> as it is, I shouldn't get _those_ results IMHO.

Indeed, you should not get such results.  If  you  compare  with  the
lmbench  results  of  our 2.4/2.6 comparison, you will notice that we
did NOT see such behaviour. There was a  perfromnce  degradation  for
pure  integer tests, due to increased system overhead, but far from a
factor of 2.
See http://www.denx.de/wiki/pub/Know/Linux24vs26/lmbench_results

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A fanatic is a person who can't change his mind and won't change  the
subject.                                          - Winston Churchill
