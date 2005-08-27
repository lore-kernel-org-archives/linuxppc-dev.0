Return-Path: <glikely@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.206])
	by ozlabs.org (Postfix) with ESMTP id BCC0E680A4
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2005 15:15:18 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id a36so929585rnf
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2005 22:15:17 -0700 (PDT)
Date: Fri, 26 Aug 2005 23:04:22 -0600
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050827050422.GC7234@siegfried.thelikelysolution.ca>
References: <DCEAAC0833DD314AB0B58112AD99B93B859440@ismail.innsys.innovsys.com>
	<20050826225509.GF5541@smtp.west.cox.net>
	<da1e14409c0face6cee5b4d5fa750c00@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <da1e14409c0face6cee5b4d5fa750c00@embeddededge.com>
From: Grant Likely <glikely@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <galak@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 26, 2005 at 07:07:01PM -0400, Dan Malek wrote:
> 
> On Aug 26, 2005, at 6:55 PM, Tom Rini wrote:
> 
> >Yes, it was.  With 2.6.13 and on i386 (and other arches that actually
> >make use of the question) it can be any of 100, 250 or 1000.
> 
> Well, 250 just seems wrong as I mentioned in a previous message.
> It will function, but an application is going to see lots of clock 
> jitter
> unless you work in multiples of 100.  My choices would be 100, 200,
> 500, or 1000.
What's the reason for clock jitter?  Is it because most timeouts are set
to multiples of 100, or some other reason?

Thanks,
g.
