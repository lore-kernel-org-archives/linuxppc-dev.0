Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id DE992DDF26
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 05:46:46 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so225828ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 10:46:41 -0800 (PST)
Message-ID: <528646bc0701311046p7d65a5d2v885dff361a2b9297@mail.gmail.com>
Date: Wed, 31 Jan 2007 11:46:41 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: Joe <joe-worker@anti-paladin.com>
Subject: Re: Led astray? Xilinx ml410 + u-boot + Linux?
In-Reply-To: <89CE61D4-C939-4788-A0AE-30EF410E9628@anti-paladin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <89CE61D4-C939-4788-A0AE-30EF410E9628@anti-paladin.com>
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

On 1/29/07, Joe <joe-worker@anti-paladin.com> wrote:
> Linux 2.6.19 shows arc/ppc/configs/ml[403|300]_defconfig,
> but I see *zero* indication that the 410 is supported.  Has anyone seen the
> ML410 fully functional with Linux + a patch to enable the Ethernet ports?
> (I also note that on the mvi$ta site they list support for:  ML300 and ML40x
> -- but NOT the ML410.)  My searches also seem to indicate that the IP
> included for the 410 Ethernet MAC's is distinctly different from the 403...

Correct, no patches to support 410 have been submitted to either the
u-boot or linuxppc mailing lists as far as I know.  You'll need to get
the patches directly from Xilinx.  I do know that they exist, but I
have not worked with them at all as I don't have access to an ML410.

> OTOH, if someone could confirm that this platform is NOT currently supported
> that would be just as useful -- decisions can be made and actions taken.

There are a number of Xilinx folks who hang out on this list,
hopefully one of them will see your question and reply.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
