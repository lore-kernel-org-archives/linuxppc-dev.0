Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (scrye.com
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 94B0E2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 18:03:20 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
From: Anthony Foiani <tkil@scrye.com>
References: <20130823192532.GA29205@home.buserror.net>
 <gppt4gel1.fsf@dworkin.scrye.com>
 <1377301643.20722.109.camel@snotra.buserror.net>
Date: Sat, 24 Aug 2013 02:03:14 -0600
In-Reply-To: <1377301643.20722.109.camel@snotra.buserror.net> (Scott Wood's
 message of "Fri\, 23 Aug 2013 18\:47\:23 -0500")
Message-ID: <gd2p3h5x9.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Li Yang-R58472 <r58472@freescale.com>,
 "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Shaohui.Xie@freescale.com, Adrian Bunk <bunk@stusta.de>
Reply-To: Anthony Foiani <tkil@scrye.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> writes:

> On Fri, 2013-08-23 at 17:41 -0600, Anthony Foiani wrote:
> > In my original patch [...]  I used "fsl,sata-max-gen".  I thought
> > Jeff disliked it, so I changed it be more generic -- but maybe I
> > misread his complaint.  (And while his opinions are still
> > respected, new maintainers might have different tastes.)
>
> I didn't see anything to that effect from Jeff in that thread -- maybe
> it was elsewhere.

I think I'm referring to this message:

  http://article.gmane.org/gmane.linux.ports.ppc.embedded/58720

As he was referring me to generic methods, I inferred that I should be
providing generic knobs...

> The device tree describes the hardware, not the driver -- and thus
> should be free to use clearer wording. :-)

*nod*

> As for fsl-specific versus generic, generic is fine but then it
> needs to be documented in a generic place.

Agreed.  I actually prefer the "generation" nomenclature, as it has a
more direct/straightforward interpretation.  ("speed=1" vs
"generation=1"; the latter is a much bigger clue, IMHO.)

> Sorry, linux-ide.

Ok, thanks.

I'll wait a few days to see if there are any other comments or
concerns, then I'll spin a final version

As always, thanks for the review and insight!

Best regards,
Anthony Foiani
