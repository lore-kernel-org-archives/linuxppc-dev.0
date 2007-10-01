Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by ozlabs.org (Postfix) with ESMTP id E9ABADDE1A
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 01:15:54 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so2537378nzh
	for <linuxppc-dev@ozlabs.org>; Mon, 01 Oct 2007 08:15:52 -0700 (PDT)
Message-ID: <fa686aa40710010815p26a61c95j373f246ad5fb822f@mail.gmail.com>
Date: Mon, 1 Oct 2007 09:15:51 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCHv2 4/4] Virtex: Add generic Xilinx Virtex board support
In-Reply-To: <20071002010630.e78e4889.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070930221613.583.252.stgit@trillian.cg.shawcable.net>
	<20070930222048.583.82010.stgit@trillian.cg.shawcable.net>
	<20071002010630.e78e4889.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/1/07, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Sun, 30 Sep 2007 16:20:52 -0600 Grant Likely <grant.likely@secretlab.ca> wrote:
> >
> > +++ b/arch/powerpc/platforms/40x/virtex.c
> > +#include <asm/of_platform.h>
>
> /me puts on broken record voice  :-)
>
> linux/of_platform.h, please

Done

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
