Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E647567B96
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2006 02:59:00 +1000 (EST)
Message-ID: <44FC5B40.5000308@s5r6.in-berlin.de>
Date: Mon, 04 Sep 2006 18:58:40 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
References: <20060817230347.GC3440@localhost> <20060818234930.GB2662@localhost>
	<44E6D634.3000207@s5r6.in-berlin.de>
	<20060823002801.GA2709@localhost> <20060824192200.GA2715@localhost>
	<44F9D8EF.6010101@s5r6.in-berlin.de>
	<20060902232644.GB2814@localhost>
In-Reply-To: <20060902232644.GB2814@localhost>
Content-Type: text/plain; charset=ISO-8859-1
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

Wolfgang Pfeiffer wrote on :
...
> # /sbin/hdparm -tT /dev/sda
> 
> /dev/sda:
>  Timing cached reads:   1244 MB in  2.00 seconds = 620.49 MB/sec
>  Timing buffered disk reads:   34 MB in  3.02 seconds =  11.24 MB/sec
...
>  Timing buffered disk reads:   34 MB in  3.04 seconds =  11.17 MB/sec
...
>  Timing buffered disk reads:   36 MB in  3.07 seconds =  11.72 MB/sec
...

Looks quite slow. I get 18 MB/s from a 20GB 2.5" HDD in an 1394a
enclosure, on an 1394a adapter or same on an 1394b adapter. The HDD was
actually taken out of a TiBook some time ago.

But I have no reference values of PowerBooks in target disk mode. This
mode is probably not optimized for performance.
-- 
Stefan Richter
-=====-=-==- =--= --=--
http://arcgraph.de/sr/
