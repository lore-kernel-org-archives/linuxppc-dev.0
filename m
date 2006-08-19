Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2731F679E9
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 19:35:25 +1000 (EST)
Message-ID: <44E6DAB9.50304@s5r6.in-berlin.de>
Date: Sat, 19 Aug 2006 11:32:41 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Bill Fink <billfink@mindspring.com>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
References: <20060817230347.GC3440@localhost>
	<20060818012824.22e70b0f.billfink@mindspring.com>
In-Reply-To: <20060818012824.22e70b0f.billfink@mindspring.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux1394-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bill Fink wrote:
...
> on my desktop PowerMac systems, I need a "sleep 2"
> before the modprobe for sbp2, to get my Firewire disks to work
> properly.

What happens if you don't put the pause in there? What disks do you have 
and what bridge chips are built in? (Please apologize if you reported 
this before and we didn't come to a solution then.)
-- 
Stefan Richter
-=====-=-==- =--- =--==
http://arcgraph.de/sr/
