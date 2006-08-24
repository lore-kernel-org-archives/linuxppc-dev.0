Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8AB3C67D29
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 05:46:51 +1000 (EST)
Message-ID: <44EE0173.9060403@s5r6.in-berlin.de>
Date: Thu, 24 Aug 2006 21:43:47 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
References: <20060817230347.GC3440@localhost> <20060818234930.GB2662@localhost>
	<44E6D634.3000207@s5r6.in-berlin.de>
	<20060823002801.GA2709@localhost> <20060824192200.GA2715@localhost>
In-Reply-To: <20060824192200.GA2715@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Wolfgang Pfeiffer wrote:
...
> Because i hate to burden my lousy memory with what I did to produce
> the logs above, I scrambled together my admittedly marginal bash
> knowledge and ran the tests with 4 scripts to produce the logs.
> 
> All the following below is to give you control on how these logs were
> created.
...

Thanks, I will look at them as soon as I have my lookup table for the 
hex codes and the mental capacity available. :-) BTW, a convenient way 
to annotate the syslog is the command "logger". E.g.
$ logger "hello world"
$ ./hello_world 2>&1 | logger -t hi_world
-- 
Stefan Richter
-=====-=-==- =--- ==---
http://arcgraph.de/sr/
