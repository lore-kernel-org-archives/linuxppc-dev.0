Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f175.google.com (mail-iw0-f175.google.com
	[209.85.223.175]) by ozlabs.org (Postfix) with ESMTP id 060E7B7D03
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 03:17:14 +1100 (EST)
Received: by iwn5 with SMTP id 5so571424iwn.9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 09:17:13 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BAB816F.5060405@firmworks.com>
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003232307s39af071bn6377800951d6615c@mail.gmail.com>
	<ed82fe3e1003240505h59d29c83x6948f8b3b70c4570@mail.gmail.com>
	<90D93687-940F-47FB-8CEA-F3C065EA611D@kernel.crashing.org>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 25 Mar 2010 10:16:52 -0600
Message-ID: <fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
To: Mitch Bradley <wmb@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	devicetree-discuss@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 25, 2010 at 9:29 AM, Mitch Bradley <wmb@firmworks.com> wrote:
> It seems to me that there are plausible use cases for both direct-inclusi=
on
> and indirection. =A0I don't see any real problems with either, so I would=
 vote
> for specifying both alternatives.

Ugh.  Then this one driver would need to implement both binding for
little, if any, actual benefit.  I'm sure we can come to an agreement
on one method if the firmware absolutely has to be in the tree.

Personally, my vote lies with direct-inclusion.  However, if
indirection is used, then I think it would be wise to define where
data-only nodes like this should live.  Under /chosen perhaps?  It
wouldn't be good to place it somewhere where it will be confused for
an actual device node.

g.
