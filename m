Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5B4B67E12
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 01:15:39 +1000 (EST)
To: Paul Nasrat <pnasrat@redhat.com>
Subject: Re: [PATCH] powerpc: Add FSL CPM2 device tree node documentation 
In-Reply-To: Your message of "Thu, 13 Apr 2006 01:14:56 EDT."
	<1144905296.29397.40.camel@enki.eridu>
References: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
	<1143564910.2660.4.camel@enki.eridu>
	<644FB6AC-3702-41D0-A9E2-6FDEC52B819D@freescale.com>
	<1144905296.29397.40.camel@enki.eridu>
Date: Thu, 13 Apr 2006 10:15:26 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FU3Xa-0005xd-9m@jdl.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Paul Nasrat mumbled:
> 
> Well I'm biased and say we shouldn't reinvent the wheel with dtc if we
> don't need to.  I've sent Jon a patch to start validating this for dtc
> and am waiting feedback before I add additional device_types.

What other device_types do you want to check? 

> So we
> should have local-mac-address be preassiged hwaddr and mac-address last
> used. For some setups this would be the same persistently, but I can
> envisage some non OF setups populating mac-address from the card. 

I'm sitting at a conference right now.  I'll slate 
some time for looking into it early next week.

jdl
