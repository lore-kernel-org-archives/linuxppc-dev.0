Return-Path: <walt.wimer@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 6ED5667B7C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 06:46:42 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by postfix.timesys.com (Postfix) with ESMTP id 389C28069799
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 16:46:44 -0400 (EDT)
Received: from postfix.timesys.com ([127.0.0.1])
	by localhost (postfix.timesys.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26915-10 for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 16:46:37 -0400 (EDT)
Received: from exchange.timesys.com (exchange.timesys.com [192.168.2.250])
	by postfix.timesys.com (Postfix) with ESMTP id D3DFA8069794
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 16:46:37 -0400 (EDT)
Subject: Re: IMAP_ADDR on PPC 8xx
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <20060509202257.551DF352B2A@atlas.denx.de>
References: <20060509202257.551DF352B2A@atlas.denx.de>
Content-Type: text/plain
Date: Tue, 09 May 2006 16:46:03 -0400
Message-Id: <1147207564.3139.20.camel@excalibur.timesys.com>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-09 at 22:22 +0200, Wolfgang Denk wrote:
> In message <1147194879.2200.41.camel@excalibur.timesys.com> you wrote:
> > 
> > Thanks again for the advice.  Interestingly, I gave the wrong
> > address above.  It wasn't 0x22000000, it was 0x02200000 (i.e.
> > even lower!).  And yet with the "io_remap()'ed global variable"
> > patch, 2.6.11.7 does indeed work on this board with this U-Boot....
> > Perhaps this works because this particular board only has 8MiB of
> > RAM....
> 
> It does not work. It will certainly crash as soon as you start a  few
> user space applications.


Well, something "interesting" is certainly going on because our 2.6.11.7
kernel *does* work and *does not* crash when running user space
applications.  It runs BusyBox quite happily with multiple processes
(e.g. 3 incoming telnet sessions, a console shell, etc.).

I can only conclude that there is something more to our 2.6.11.7-based
patch than I currently understand.



Cheers!

Walt
