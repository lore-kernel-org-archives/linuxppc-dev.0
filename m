Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by ozlabs.org (Postfix) with ESMTP id 20E45DDDD8
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 00:25:54 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so167028nzf
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 07:25:53 -0700 (PDT)
Message-ID: <fa686aa40707250725ob38a9dax3eca9d7b8d03828f@mail.gmail.com>
Date: Wed, 25 Jul 2007 08:25:53 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: michael@ellerman.id.au
Subject: Re: [PATCH] xmon consistency clean up
In-Reply-To: <1185365630.21877.4.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200707250257.l6P2va65006958@toshiba.co.jp>
	<1185344499.5439.307.camel@localhost.localdomain>
	<1185365630.21877.4.camel@concordia.ozlabs.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/25/07, Michael Ellerman <michael@ellerman.id.au> wrote:
> On Wed, 2007-07-25 at 16:21 +1000, Benjamin Herrenschmidt wrote:
> > Nah, keep it xmon_puts, since it doesn't take a stream argument and
> > define a "puts" for use by xmon core.
>
> But then it needs to add a newline .. and we've gone around in a circle
> again. Funny how the trivialest of patches gets the most review.

And the bike shed needs to be green.

http://www.freebsd.org/doc/en_US.ISO8859-1/books/faq/misc.html#BIKESHED-PAINTING

:-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
