Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC8FADDECB
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:08:40 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6AL8bSR022181
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 17:08:37 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6AL8TYl088256
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 15:08:29 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6AL8Sbw006599
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 15:08:28 -0600
Subject: Re: Resend: [PATCH] oprofile support for Power 5++
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <911.1184099498@neuling.org>
References: <4693CC5B.4020207@linux.vnet.ibm.com>
	<14287.1184096639@neuling.org> <4693E7EF.4020708@linux.vnet.ibm.com>
	<911.1184099498@neuling.org>
Content-Type: text/plain
Date: Tue, 10 Jul 2007 16:07:39 -0500
Message-Id: <1184101660.22547.104.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mjw@linux.vnet.ibm.com
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-10 at 15:31 -0500, Michael Neuling wrote:
> > >
> > > Does it make more sense to call this "ppc64/power5+rev3"?  
> > >   
> > This is a change to support new counter setup for oprofile.  It may be the
> > same if there is a revision 4 or 5 etc.  So since the internal name was ++
> > I followed that convention. 

There is an oprofile change already made, or in-flight, or at least
submitted, that will be looking for the "power5++" string, so if the
string changes here, it'll need to be changed there too. 

( http://article.gmane.org/gmane.linux.oprofile/4670 )

> 
> I'm not too fussed, but if rev 4 comes out, the counters change and we
> need power5+++, it's gonna look pretty silly :-)

silly, but would be funny to see.  :-) 

> 
> Mikey
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
