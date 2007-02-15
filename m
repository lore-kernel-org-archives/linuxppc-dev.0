Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
In-Reply-To: Your message of "Fri, 16 Feb 2007 09:19:07 +1100."
	<20070215221907.GC19126@localhost.localdomain>
References: <E1HHkAL-0005Xl-2f@jdl.com>
	<20070215221907.GC19126@localhost.localdomain>
Date: Thu, 15 Feb 2007 17:43:46 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HHqGQ-0007uu-Ak@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> 
> I'd prefer a different name for this - and possibly it should go in a
> different file.  The data_* prefix should be for functions that
> actually manipulate struct data objects.

...

> And I'd really prefer to keep the yyblah junk confined to the parser
> code.  I think it would be better to move this function into
> dtc-parser.y

OK.  Yeah, that's sort of what I was alluding to with
the "don't stress the yylval gunk".  But OK, in any event
I'll move this function to the parser file or so.

> Otherwise looks pretty good.

Thanks.

jdl
