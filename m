Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 676A267C40
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 08:55:59 +1000 (EST)
Date: Fri, 25 Aug 2006 00:56:26 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
Message-ID: <20060824225626.GA4100@localhost>
References: <20060817230347.GC3440@localhost> <20060818234930.GB2662@localhost>
	<44E6D634.3000207@s5r6.in-berlin.de>
	<20060823002801.GA2709@localhost> <20060824192200.GA2715@localhost>
	<44EE0173.9060403@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44EE0173.9060403@s5r6.in-berlin.de>
Cc: linuxppc-dev@ozlabs.org, billfink@mindspring.com,
	linux1394-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 24, 2006 at 09:43:47PM +0200, Stefan Richter wrote:
> Wolfgang Pfeiffer wrote:
> ...
> >Because i hate to burden my lousy memory with what I did to produce
> >the logs above, I scrambled together my admittedly marginal bash
> >knowledge and ran the tests with 4 scripts to produce the logs.
> >
> >All the following below is to give you control on how these logs were
> >created.
> ...
> 
> Thanks, I will look at them as soon as I have my lookup table for the 
> hex codes and the mental capacity available. :-) BTW, a convenient way 
> to annotate the syslog is the command "logger". E.g.
> $ logger "hello world"
> $ ./hello_world 2>&1 | logger -t hi_world

I'll keep that on my radar for the next time I could use 'logger' ...
But after reading the - how do I say that without becoming offensive,
- err .. possibly slightly esoteric explanations in "man logger" I'm
not that much enthusiastic to use the tool ... but let's see .. :)

Note: Please ignore most of the ugly explanations on how I created the
logs for ieee1394 in my previous mail. Some should be nothing more
than a reference if (and only if) the ieee logs I put on my home page
don't help to debug the FW issue ...

Thanks 

Best regards
Wolfgang    

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
