Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id E0BC8DDE2C
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 06:31:14 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: mjw@linux.vnet.ibm.com
Subject: Re: Resend: [PATCH] oprofile support for Power 5++ 
In-reply-to: <4693E7EF.4020708@linux.vnet.ibm.com> 
References: <4693CC5B.4020207@linux.vnet.ibm.com>
	<14287.1184096639@neuling.org>
	<4693E7EF.4020708@linux.vnet.ibm.com>
Date: Tue, 10 Jul 2007 15:31:38 -0500
Message-ID: <911.1184099498@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >
> > Does it make more sense to call this "ppc64/power5+rev3"?  
> >   
> This is a change to support new counter setup for oprofile.  It may be the
> same if there is a revision 4 or 5 etc.  So since the internal name was ++
> I followed that convention. 

I'm not too fussed, but if rev 4 comes out, the counters change and we
need power5+++, it's gonna look pretty silly :-)

Mikey
