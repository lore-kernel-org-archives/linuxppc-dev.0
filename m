Return-Path: <glikely@secretlab.ca>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.180])
	by ozlabs.org (Postfix) with ESMTP id DC7FCDDE34
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:01:25 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id s27so701954ele
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 13:01:24 -0700 (PDT)
Message-ID: <fa686aa40709281301uf3fb7c0mdb7ee05643b3bc60@mail.gmail.com>
Date: Fri, 28 Sep 2007 14:01:23 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 12/18] Uartlite: Let the console be initialized earlier
In-Reply-To: <200709282140.07000.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181754.18608.52779.stgit@trillian.cg.shawcable.net>
	<200709282140.07000.arnd@arndb.de>
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
> > +#else /* CONFIG_OF */
> > +static void __init ulite_console_of_find_device(int id) { /* do nothing */ }
> > +#endif /* CONFIG_OF */
>
> Shouldn't this be inline? It shouldn't matter much since most of the time
> gcc -funit-at-a-time takes care of this, but it's common to make the inlining
> explicit.

heh, I even had the inline in there on an earlier version of the
patch.  I can add it back it.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
