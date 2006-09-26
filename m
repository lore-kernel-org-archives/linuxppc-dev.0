Return-Path: <jschopp@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5661167BCC
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 02:24:32 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8QGOT7Y009160
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 12:24:29 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8QGOKiL065474
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 10:24:21 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8QGOKwa000748
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 10:24:20 -0600
Message-ID: <45195432.2090108@austin.ibm.com>
Date: Tue, 26 Sep 2006 11:24:18 -0500
From: jschopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: ingvar@linpro.no
Subject: Re: DLPAR fails on SLES9
References: <83wt7qkiz1.fsf@uname.e.linpro.no>
In-Reply-To: <83wt7qkiz1.fsf@uname.e.linpro.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Is it possible to update the HMC, for example to 5.x.something without
> updating (read boot) the managed systems as well?

Yes, you should be able to update the HMC independently.  Though having up to date 
firmware on your managed system is also a good idea when you can afford the downtime (reboot).
