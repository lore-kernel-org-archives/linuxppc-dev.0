Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id DE90E67C1A
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 15:01:00 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so923103ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Nov 2006 20:00:55 -0800 (PST)
Message-ID: <528646bc0611062000p53e49762s9bf0c7eebcf284ec@mail.gmail.com>
Date: Mon, 6 Nov 2006 21:00:54 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/5] [RFC] Add support for lite5200b to arch/powerpc
In-Reply-To: <1162865073.28571.390.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11628596653052-git-send-email-grant.likely@secretlab.ca>
	<11628596751096-git-send-email-grant.likely@secretlab.ca>
	<11628596753992-git-send-email-grant.likely@secretlab.ca>
	<1162865073.28571.390.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/6/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > +static int __init lite5200_probe(void)
> > +{
> > +     unsigned long node = of_get_flat_dt_root();
> > +     const char *model = of_get_flat_dt_prop(node, "model", NULL);
> > +
> > +     if (!of_flat_dt_is_compatible(node, "mpc52xx"))
> > +             return 0;
> > +     pr_debug("%s board w/ mpc52xx found\n", model ? model : "unknown");
> > +
> > +     return 1;
> > +}
>
> Are you creating a "generic" mpc52xx machine or a "lite5200b" machine ?
>
> If you do the former, it will try to match on any board with that
> compatible propery, thus any mpc52xx based board. That is probably not
> what you want.

Heh, I got lazy.  I'll fix this.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
