Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by ozlabs.org (Postfix) with ESMTP id 947C9DDDF7
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 10:32:51 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so870656nzh
	for <linuxppc-dev@ozlabs.org>; Sun, 04 Nov 2007 15:32:50 -0800 (PST)
Message-ID: <fa686aa40711041532u21e95467i444e999ae45c2f03@mail.gmail.com>
Date: Sun, 4 Nov 2007 16:32:49 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Kumar Gala" <galak@kernel.crashing.org>,
	"linux-ppc list" <linuxppc-dev@ozlabs.org>,
	"U-Boot Users List" <u-boot-users@lists.sourceforge.net>
Subject: Re: [U-Boot-Users] use of aliases in device trees
In-Reply-To: <20071104224256.GC15444@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <DD2A9B2C-5D35-4F53-8542-3470C6FA5265@kernel.crashing.org>
	<fa686aa40711032029x3871b76m5b44a6e93d8d7217@mail.gmail.com>
	<20071104224256.GC15444@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/4/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Sat, Nov 03, 2007 at 09:29:48PM -0600, Grant Likely wrote:
> > Maybe something like:
> > aliases {
> >       enet0,phandle = <&enet0>;
> >       enet1,phandle = <&enet1>;
> >       ...
> > };
>
> The fairly small advantages of using phandles here are not worth the
> hassle of defining a new alias format, when the OF one with full paths
> already exists.
>
> I would, however, like to extend dtc so that we can do something like:
>         aliases {
>                 enet0 = &enet0;
>         };
> and the reference in non-cell context will expand to the full path.
> That could be used for things like linux,stdout-path in /chosen, too.
>
> I'd also like to extend dtc so that the label can be tagged somehow, say:
>         *enet0: { ... };
> and as well as creating a normal dtc label, an alias will also be
> automatically added to /aliases.

Yeah, okay!  I like both of those ideas.  That certainly addresses my
ease of maintenance concerns.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
