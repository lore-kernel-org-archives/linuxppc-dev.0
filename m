Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7B82B7D29
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 15:30:11 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp08.in.ibm.com (8.14.3/8.13.1) with ESMTP id o2A3icMC002492
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 09:14:38 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2A4U97S2973858
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 10:00:09 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2A4U8EN008759
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 10:00:09 +0530
Date: Wed, 10 Mar 2010 10:00:02 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC] powerpc: add support for new hcall H_BEST_ENERGY
Message-ID: <20100310043002.GA15046@dirshya.in.ibm.com>
References: <20100303181822.GH5439@dirshya.in.ibm.com>
	<20100305191810.GA10402@in.ibm.com>
	<20100308065006.GA6281@dirshya.in.ibm.com>
	<20100308192826.GJ10402@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20100308192826.GJ10402@in.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	linuxppc-dev@ozlabs.org
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Dipankar Sarma <dipankar@in.ibm.com> [2010-03-09 00:58:26]:

> On Mon, Mar 08, 2010 at 12:20:06PM +0530, Vaidyanathan Srinivasan wrote:
> > * Dipankar Sarma <dipankar@in.ibm.com> [2010-03-06 00:48:11]:
> > 
> > > Shouldn't we create this only for supported platforms ?
> > 
> > Hi Dipankar,
> > 
> > Yes we will need a check like
> > firmware_has_feature(FW_FEATURE_BEST_ENERGY) to avoid sysfs files in
> > unsupported platforms.  I will add that check in the next iteration.
> 
> Also, given that this module isn't likely to provide anything on
> older platforms, it should get loaded only on newer platforms.

Yes, I will explore methods to achieve this.  I could not yet find
a trigger to load modules based on firmware feature.

--Vaidy
