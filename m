Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 6D5C1DDF62
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 16:06:21 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so119149anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 21:06:21 -0800 (PST)
Message-ID: <fa686aa40801092106u6b573fc5ue75542b90be22fec@mail.gmail.com>
Date: Wed, 9 Jan 2008 22:06:21 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Re: [RFC] add phy-handle property for fec_mpc52xx
In-Reply-To: <1199941261.6734.224.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080109163058.21643.30876.stgit@trillian.secretlab.ca>
	<1199941261.6734.224.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, olaf@aepfle.de, sven@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/9/08, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Wed, 2008-01-09 at 09:32 -0700, Grant Likely wrote:
> > From: Olaf Hering <olaf@aepfle.de>
> >
> > This should go into the kernel because its appearently
> > impossible to boot the script via tftp and then load the real boot
> > binary (yaboot or zimage).
> >
> > (Olaf's s-o-b line needs to go here)
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> As much as I despise having to work around firmware bugs, it looks
> indeed like this one has been broken for way too long to the point where
> users are being hurt, distros are being hurt, and telling people to
> whack things in nvramrc is just plain gross, so let's merge it.

Thanks Ben.

Olaf, can you please reply with your signed-off-by line?  Then I'll
ask paulus to pick this up for .24

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
