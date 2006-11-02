Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 5E23E67D04
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 09:32:47 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so233393ugf
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Nov 2006 14:32:45 -0800 (PST)
Message-ID: <528646bc0611021432s394c3decved965856c4b8aec@mail.gmail.com>
Date: Thu, 2 Nov 2006 15:32:41 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
In-Reply-To: <1162506319.10630.42.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0611020658le3adc94p30f372f3a1a8b07e@mail.gmail.com>
	<OF4DAC86D4.8F202745-ON8725721A.00550DB9-8525721A.00556835@us.ibm.com>
	<20061102160009.GC4928@localhost.localdomain>
	<1162506319.10630.42.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/2/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> As for new platforms, I tend to have no problem if they just create a
> directory of their own (platforms/chesnut, etc...) though in some we
> might want a grab bag for boards that really only need one file...
>
> This could be a plaforms/misc, or platforms/simple, or just have them at
> the root of platforms...

Root of platforms makes sense to me.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
