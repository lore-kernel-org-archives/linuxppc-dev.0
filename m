Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.238])
	by ozlabs.org (Postfix) with ESMTP id 97AC0DDE1C
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:02:54 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so2051129nzh
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 13:02:53 -0700 (PDT)
Message-ID: <fa686aa40709281302t3b36f335n8fec63b043a25a4a@mail.gmail.com>
Date: Fri, 28 Sep 2007 14:02:52 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 10/18] Uartlite: improve in-code comments
In-Reply-To: <200709282143.16815.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181740.18608.67126.stgit@trillian.cg.shawcable.net>
	<200709282143.16815.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/28/07, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 28 September 2007, Grant Likely wrote:
> > +/* ---------------------------------------------------------------------
> > + * Core UART driver operations
> > + */
> > +
>
> This is a rather unusual style of commenting. IMHO it would be better if you
> left out the ----- line.

I find the horizontal breaks useful when parsing through the code.  If
others agree with you, then I'll happily remove them.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
