Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.240])
	by ozlabs.org (Postfix) with ESMTP id 1A648DE1C3
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 03:44:59 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so225437agc.0
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 08:44:55 -0800 (PST)
Message-ID: <fa686aa40801090844t18fd5e2cy63dd6b3c46ca1ae2@mail.gmail.com>
Date: Wed, 9 Jan 2008 09:44:55 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: add phy-handle property for fec_mpc52xx
In-Reply-To: <4784F7D1.1050301@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080109140608.GA15673@aepfle.de> <4784E78C.40904@genesi-usa.com>
	<fa686aa40801090746k4ec5c208j9daf224cb2570071@mail.gmail.com>
	<4784F7D1.1050301@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/9/08, Matt Sealey <matt@genesi-usa.com> wrote:
> > However, I'm still inclined to pick up Olaf's patch with the
> > appropriate protections around it so it is only done if the nodes are
> > missing.
>
> Eh.. yeah. Maybe. Seems like a cop-out to me. I would rather you removed
> the patch and called us a bunch of idiots for coding bad firmware, than
> have the fixups be dependant on what could turn into a very well coded
> but essentially screen-long list of fixups for myriad firmware versions
> where the properties may or may not be present or correct for various
> firmware versions and devices.

I've come to the conclusion that Postel knew what he was talking
about; "Be conservative in what you do; be liberal in what you accept
from others."  :-)

I 100% agree that this stuff is better done in firmware.  However,
until that stuff is in place; it is 100% reasonable and desirable to
work around it in prom_init.  That being said, I will modify prom_init
to not blindly apply fixups if they have already been done in
firmware.

> Grant, are you any good at coding firmware-level stuff without utilizing
> any preexisting code under the GPL? I'd like to collaborate on an installer
> tool which can put efika.forth (and therefore all these fixes) in.

I'm good at firmware stuff, but time comes at a premium.  This level
of work would require a contract arrangement between our two
companies.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
