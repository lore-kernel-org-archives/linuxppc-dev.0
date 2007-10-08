Return-Path: <nish.aravamudan@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.187])
	by ozlabs.org (Postfix) with ESMTP id F1576DDEC2
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 13:47:25 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so1354486fkz
	for <linuxppc-dev@ozlabs.org>; Sun, 07 Oct 2007 20:47:24 -0700 (PDT)
Message-ID: <29495f1d0710072047k2790d767t2da9f018d91e5b20@mail.gmail.com>
Date: Sun, 7 Oct 2007 20:47:23 -0700
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Linas Vepstas" <linas@austin.ibm.com>
Subject: Re: 2.6.23-rc7-mm1 -- powerpc rtas panic
In-Reply-To: <20071005160322.GN4338@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070924021716.9bfe7dfb.akpm@linux-foundation.org>
	<20070924123531.GC30855@shadowen.org>
	<20071002232819.GN4338@austin.ibm.com>
	<20071003002646.GD9814@bakeyournoodle.com>
	<1191371416.8073.1.camel@concordia>
	<20071003011909.GG9814@bakeyournoodle.com>
	<29495f1d0710041701g4ed73441ie583058c78f95857@mail.gmail.com>
	<20071005160322.GN4338@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/5/07, Linas Vepstas <linas@austin.ibm.com> wrote:
> On Thu, Oct 04, 2007 at 05:01:47PM -0700, Nish Aravamudan wrote:
> > On 10/2/07, Tony Breeds <tony@bakeyournoodle.com> wrote:
> > > On Wed, Oct 03, 2007 at 10:30:16AM +1000, Michael Ellerman wrote:
> > >
> > > > I realise it'll make the patch bigger, but this doesn't seem like a
> > > > particularly good name for the variable anymore.
> > >
> > > Sure, what about?
> > >
> > > Clarify when RTAS logging is enabled.
> > >
> > > Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> >
> > For what it's worth, on a different ppc64 box, this resolves a similar
> > panic for me.
> >
> > Tested-by: Nishanth Aravamudan <nacc@us.ibm.com>
>
> For the reasons explained, I'd really like to nack Tony's patch.

I see. Can you reply in this thread with the patch you mentioned in
your other reply? (or point me to a copy of it)

Thanks,
Nish
