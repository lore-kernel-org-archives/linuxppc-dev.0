Return-Path: <glikely@secretlab.ca>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id E2066DDE27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Nov 2007 02:31:15 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1312098uge
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 07:31:13 -0800 (PST)
Message-ID: <fa686aa40711200731n61d239fdw4ac1d64a95ad97ff@mail.gmail.com>
Date: Tue, 20 Nov 2007 08:31:12 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Lorenz Kolb" <linuxppcemb@lkmail.de>
Subject: Re: ML403 USB driver
In-Reply-To: <13858912.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <13858912.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/20/07, Lorenz Kolb <linuxppcemb@lkmail.de> wrote:
>
> Hi,
>
> we just tried the USB driver (from Peter Korsgaard) from Grant's virtex
> tree.
>
> Nevertheless we could not get the peripheral ports work as gadgets.
> Has anyone tried (and probably fixed) that before?

That driver does not work for gadget ports.

>
> Anyway, only one of the two peripheral ports seems to be active.

Yes, I've got that problem here too.  I haven't yet solved it.  Any
help would be appreciated.

> We use kernel 2.6.22 (as some usb related stuff has recently changed and the
> driver would have to be changed), usb host works (usb-storage, cdc_ether,
> some more stuff we tested)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
