Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C1B12C0091
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 09:47:35 +1000 (EST)
Message-ID: <1377301643.20722.109.camel@snotra.buserror.net>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
From: Scott Wood <scottwood@freescale.com>
To: Anthony Foiani <tkil@scrye.com>
Date: Fri, 23 Aug 2013 18:47:23 -0500
In-Reply-To: <gppt4gel1.fsf@dworkin.scrye.com>
References: <20130823192532.GA29205@home.buserror.net>
 <gppt4gel1.fsf@dworkin.scrye.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Adrian Bunk <bunk@stusta.de>, "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Shaohui.Xie@freescale.com, Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-23 at 17:41 -0600, Anthony Foiani wrote:
> Scott Wood <scottwood@freescale.com> writes:
> 
> >> --- a/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> >> +++ b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
> >
> > This should go in Documentation/devicetree/bindings/ata/fsl-sata.txt.
> 
> Ok, will change.
> 
> > As for the property name, I'd prefer "fsl,sata-speed-limit" or
> > "fsl,sata-max-generation".  
> 
> In my original patch:
> 
>   http://article.gmane.org/gmane.linux.ports.ppc.embedded/58710
> 
> I used "fsl,sata-max-gen".  I thought Jeff disliked it, so I changed
> it be more generic -- but maybe I misread his complaint.  (And while
> his opinions are still respected, new maintainers might have different
> tastes.)

I didn't see anything to that effect from Jeff in that thread -- maybe
it was elsewhere.

> I think my logic was that there exist "sata_spd_limit" and related
> functions in the ata core, so I should mirror that in the dev tree.
> No guarantees, though -- it's been a while since I wrote that code.

The device tree describes the hardware, not the driver -- and thus
should be free to use clearer wording. :-)

As for fsl-specific versus generic, generic is fine but then it needs to
be documented in a generic place.

> > Shaohui, do the driver bits look OK?
> 
> > This patch should go via the linux-scsi list (note that Tejun Heo is
> > now the SATA maintainer).
> 
> linux-scsi, or linux-ide?  My other recent change to sata_fsl went
> through the latter.

Sorry, linux-ide.

-Scott
