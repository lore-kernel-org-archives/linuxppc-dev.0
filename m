Return-Path: <jjboor@aimsys.nl>
Received: from linserv001.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26E0967A45
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Mar 2006 04:16:01 +1100 (EST)
Received: from linpc041.aimsys.nl (linpc041.aimsys.nl [10.10.4.185])
	(authenticated bits=0)
	by linserv001.aimsys.nl (8.12.8/8.12.8) with ESMTP id k2AHA1RE001004
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Mar 2006 18:10:01 +0100
Subject: Re: How to quickly write cleanmarkers to jffs2 partitions?
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: linuxppc <linuxppc-dev@ozlabs.org>
In-Reply-To: <200603080938.35299.david.jander@protonic.nl>
References: <200603021706.14618.david.jander@protonic.nl>
	<200603031008.20075.mathieu.deschamps@com2gether.net>
	<1141647684.23522.7.camel@linpc041.aimsys.nl>
	<200603080938.35299.david.jander@protonic.nl>
Content-Type: multipart/mixed; boundary="=-T3OgqY0/fcThefSvLhK9"
Date: Fri, 10 Mar 2006 18:10:01 +0100
Message-Id: <1142010601.9339.23.camel@linpc041.aimsys.nl>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-T3OgqY0/fcThefSvLhK9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-03-08 at 09:38 +0100, David Jander wrote:

> 
> Thanks to all for the suggestions.
> Is "cleanmark" an open-source tool? 

well, I think so, as it's a minimal modified flash_eraseall.c from mtd

> Would you share it?

sure, a gzipped version is attached. Put it in the mtd/util directory
and add it to the Makefile there (to TARGETS) and:

cleanmark: crc32.o cleanmark.o
        $(CC) $(LDFLAGS) -o $@ $^


best regards,

Jaap-Jan

> 
> Greetings,
> 
> -- 
> David Jander
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

--=-T3OgqY0/fcThefSvLhK9
Content-Disposition: inline; filename=cleanmark.c.gz
Content-Type: application/x-gzip; name=cleanmark.c.gz
Content-Transfer-Encoding: base64

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
AAA=


--=-T3OgqY0/fcThefSvLhK9--
