Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13668DDEDF
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 04:16:26 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n36IGMH8012850
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Apr 2009 11:16:23 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n36IGMbM007791
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Apr 2009 13:16:22 -0500 (CDT)
Date: Mon, 6 Apr 2009 13:16:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: Yigal Goldberger <yigal_gold@yahoo.com>
Subject: Re: making cuImage with ELDK 4.2
Message-ID: <20090406181621.GA4001@ld0162-tx32.am.freescale.net>
References: <932829.65089.qm@web38905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <932829.65089.qm@web38905.mail.mud.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 06, 2009 at 04:14:51AM -0700, Yigal Goldberger wrote:
> 
> Hi all,
> I'm trying to make cuImage using kernel 2.6.24.2 .
> The problem is I can't find a match between a dtc version and a dts file that will compile . I took dtc-v1.2.0 from several sources and tried to make them . They all fail with the same error : 
> 	 CC dtc-lexer.lex.o
> dtc-lexer.lex.c: In function `yylex':
> dtc-lexer.lex.c:762: warning: label `find_rule' defined but not used
> dtc-lexer.l: At top level:
> dtc-lexer.lex.c:1870: warning: 'yy_flex_realloc' defined but not used
> 	 CC dtc-parser.tab.o

I believe you need a newer flex.

And a newer kernel, but not because of this. :-)

-Scott
