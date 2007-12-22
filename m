Return-Path: <cbouatmailru@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by ozlabs.org (Postfix) with ESMTP id 40867DDDEE
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 05:49:21 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w8so756410mue.1
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 10:49:19 -0800 (PST)
Date: Sat, 22 Dec 2007 21:38:37 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH 4/4] [POWERPC] CPM1: implement GPIO API
Message-ID: <20071222183837.GA4870@zarina>
References: <20071221202824.GA4607@localhost.localdomain>
	<20071221203431.GD4633@localhost.localdomain>
	<476CDECB.3010409@scram.de> <476D366E.1030104@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <476D366E.1030104@scram.de>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 22, 2007 at 05:08:14PM +0100, Jochen Friedrich wrote:
> Hi Anton,
> 
> > I also hope you'll test it. ;-)
> 
> yes.
> 
> > +int cpm_init_par_io(void)
> > +{
> > +       struct device_node *np;
> > +       const u32 *num_ports;
> > +
> > +       np = of_find_node_by_name(NULL, "fsl,cpm1-pario");
> > +       if (!np)
> > +               return -ENOENT;
> > +
> 
> I guess this should be:
> 
>  np = of_find_compatible_node(NULL, NULL, "fsl,cpm1-pario");
> 
> With this modification it works OK for me :)

Fixed, thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
