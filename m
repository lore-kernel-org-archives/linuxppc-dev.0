Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 6BE34DE1C5
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 16:26:48 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so242499anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 23:26:47 -0700 (PDT)
Message-ID: <fa686aa40805232326w35f455d1s274899160d47eccb@mail.gmail.com>
Date: Sat, 24 May 2008 00:26:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
In-Reply-To: <200805221905.32288.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
	<20080521151928.GA28857@polina.dev.rtsoft.ru>
	<200805221905.32288.david-b@pacbell.net>
Cc: fabrizio.garetto@gmail.com, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 22, 2008 at 8:05 PM, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 21 May 2008, Anton Vorontsov wrote:
>> > +++ b/drivers/spi/spi_of.c
>>
>> I think better placement for this is drivers/of, no?
>
> Yes please.

Okay, I wasn't sure.  Will do.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
