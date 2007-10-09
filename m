Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id E1037DDF3D
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 03:39:20 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2234456wag
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Oct 2007 10:39:19 -0700 (PDT)
Message-ID: <fa686aa40710091039hd945eb4n7dfdba3df37a08f2@mail.gmail.com>
Date: Tue, 9 Oct 2007 11:39:18 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 0/6] Patch series to add of_platform
	binding to xilinxfb
In-Reply-To: <1191906242.6083.7.camel@daplas>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
	<1191370502.5238.1.camel@daplas>
	<fa686aa40710082143k2092e7d2l35bc3bda55bb6237@mail.gmail.com>
	<1191906242.6083.7.camel@daplas>
Cc: linuxppc <linuxppc-dev@ozlabs.org>, akonovalov@ru.mvista.com,
	linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/8/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> On Mon, 2007-10-08 at 22:43 -0600, Grant Likely wrote:
> > BTW, what path do framebuffer patches take to get into Linus' tree?
> > Does he pull your tree directly, or do they go through someone else's
> > tree?
>
> They all go to -mm tree, unless it's a needed fix, then to Linus's.
>
> Tony

Ah, okay.

Since the XilinxFB is a powerpc-only device, is it okay with you if I
get Paul Mackerras to merge them into his tree instead (that way the
changes go in with the platform code which requires these changes)

Paulus, is that okay by you?

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
