Return-Path: <tkil@scrye.com>
Received: from mail.scrye.com (scrye.com
 [IPv6:2001:470:b8bc:cafe:5054:ff:fedc:793f])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail.scrye.com", Issuer "mail.scrye.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 922482C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 09:41:35 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
From: Anthony Foiani <tkil@scrye.com>
References: <20130823192532.GA29205@home.buserror.net>
Date: Fri, 23 Aug 2013 17:41:30 -0600
In-Reply-To: <20130823192532.GA29205@home.buserror.net> (Scott Wood's message
 of "Fri\, 23 Aug 2013 14\:25\:32 -0500")
Message-ID: <gppt4gel1.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adrian Bunk <bunk@stusta.de>, "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Shaohui.Xie@freescale.com, Li Yang-R58472 <r58472@freescale.com>
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

>> --- a/Documentation/devicetree/bindings/powerpc/fsl/board.txt
>> +++ b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
>
> This should go in Documentation/devicetree/bindings/ata/fsl-sata.txt.

Ok, will change.

> As for the property name, I'd prefer "fsl,sata-speed-limit" or
> "fsl,sata-max-generation".  

In my original patch:

  http://article.gmane.org/gmane.linux.ports.ppc.embedded/58710

I used "fsl,sata-max-gen".  I thought Jeff disliked it, so I changed
it be more generic -- but maybe I misread his complaint.  (And while
his opinions are still respected, new maintainers might have different
tastes.)

I think my logic was that there exist "sata_spd_limit" and related
functions in the ata core, so I should mirror that in the dev tree.
No guarantees, though -- it's been a while since I wrote that code.

> Shaohui, do the driver bits look OK?

> This patch should go via the linux-scsi list (note that Tejun Heo is
> now the SATA maintainer).

linux-scsi, or linux-ide?  My other recent change to sata_fsl went
through the latter.

Thanks for the review / comments.  Let me know how you'd like to
proceed on the above points, and I can resubmit (as a proper patch for
easier tracking).

Best regards,
Anthony Foiani
