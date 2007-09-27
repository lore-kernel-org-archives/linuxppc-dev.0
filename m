Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C59EEDDE1B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 01:34:36 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8RFYXJZ018578
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 11:34:33 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8RFYXBu674732
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 11:34:33 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8RFYWWS018572
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 11:34:32 -0400
Date: Thu, 27 Sep 2007 10:34:27 -0500
To: Cesar Bello <cesarcabo2904@gmail.com>
Subject: Re: Help! Debian ppc64
Message-ID: <20070927153427.GA7970@austin.ibm.com>
References: <4d1254690709270657l7e3b4cdbhee90eef97b37f77@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4d1254690709270657l7e3b4cdbhee90eef97b37f77@mail.gmail.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2007 at 09:57:02AM -0400, Cesar Bello wrote:
> Hi, I'm writing from Venezuela. I have to prepair a presentation about
> Debian on IBM pSerires Servers with Power 5+ processors. My first question
> is what are the advantages of use Debian GNU/Linux on pSeries Servers?

Advantages as compared to what?

-- Debian on Intel? 
   +++ powerpc has better RAS features than Intel, for example, 
       my favorite, PCI error handling and recovery, or hotplug cpu,
       dynamic LPAR configuration, etc. 

-- SuSE/RedHat on PowerPC?
   +++ SuSE/RedHat offer formal support, for $$$, which debian/ubuntu do not

-- AIX on pSeries?
   +++ AIX has various "enterprise" features that Debian does not.

You might try talking to RedHat/SuSE product support, and also to IBM
pSeries sales.

Linas Vepstas
