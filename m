Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 5164067D57
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 02:09:11 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so359006ugc
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 09:09:07 -0700 (PDT)
Message-ID: <528646bc0610260909x10c3b242i64387f576e625048@mail.gmail.com>
Date: Thu, 26 Oct 2006 10:09:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Nicolas DET" <nd@bplan-gmbh.de>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
In-Reply-To: <528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <453FB582.20802@bplan-gmbh.de>
	<1161816783.22582.132.camel@localhost.localdomain>
	<45409760.7030902@bplan-gmbh.de>
	<1161866964.27827.2.camel@localhost.localdomain>
	<4540B0A9.6070404@bplan-gmbh.de>
	<528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/26/06, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 10/26/06, Nicolas DET <nd@bplan-gmbh.de> wrote:
> > -       chrp_find_openpic();
> > -       chrp_find_8259();
> > +
> > +       if ( chrp_find_mpc52xx_pic() < 0)
> > +       {
> > +               chrp_find_openpic();
> > +               chrp_find_8259();
> > +       }
>
> Why?  Why not just add the call to chrp_find_mpc52xx_pic() before or
> after the other two chrp_find_ calls?  Will calling them cause things
> to break?
>
> Keep the code simple.

... as possible; but no simpler.

:)

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
