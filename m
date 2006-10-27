Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id EC96967D0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 23:21:23 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so581516ugc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 06:21:22 -0700 (PDT)
Message-ID: <528646bc0610270621q70a11be1we6215b3d91465525@mail.gmail.com>
Date: Fri, 27 Oct 2006 07:21:22 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [POWERPC] MPC52xx is a 6xx variant, remove PPC_52xx config option
In-Reply-To: <1161944693.25682.70.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11618347593934-git-send-email-grant.likely@secretlab.ca>
	<4541D7D5.7090001@varma-el.com>
	<1161944693.25682.70.camel@localhost.localdomain>
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

On 10/27/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Fri, 2006-10-27 at 13:56 +0400, Andrey Volkov wrote:
> > Please _don't_ do it, since mpc5200 platform drivers depend from this
> > option.
>
> And that should be fixed. We are yet discussing the proper way of
> integrating 52xx in arch/powerpc, but that definitely doesn't involve
> making it an exclusive processor type. Besides, there will probably be
> enough changes in the drivers to adapt them to of_platform_device type
> probing that we might just well fork them all anyway.

Besides; this is only arch/powerpc.  52xx doesn't event boot on
arch/powerpc yet.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
