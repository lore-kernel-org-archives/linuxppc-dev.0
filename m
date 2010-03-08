Return-Path: <dipankar@in.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51361B7CFB
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 06:28:37 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp08.in.ibm.com (8.14.3/8.13.1) with ESMTP id o28IhMoG031397
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Mar 2010 00:13:23 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o28JSZqc2957366
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Mar 2010 00:58:35 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o28JSY2Q025470
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Mar 2010 06:28:34 +1100
Date: Tue, 9 Mar 2010 00:58:26 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [RFC] powerpc: add support for new hcall H_BEST_ENERGY
Message-ID: <20100308192826.GJ10402@in.ibm.com>
References: <20100303181822.GH5439@dirshya.in.ibm.com>
	<20100305191810.GA10402@in.ibm.com>
	<20100308065006.GA6281@dirshya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100308065006.GA6281@dirshya.in.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	linuxppc-dev@ozlabs.org
Reply-To: dipankar@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 08, 2010 at 12:20:06PM +0530, Vaidyanathan Srinivasan wrote:
> * Dipankar Sarma <dipankar@in.ibm.com> [2010-03-06 00:48:11]:
> 
> > Shouldn't we create this only for supported platforms ?
> 
> Hi Dipankar,
> 
> Yes we will need a check like
> firmware_has_feature(FW_FEATURE_BEST_ENERGY) to avoid sysfs files in
> unsupported platforms.  I will add that check in the next iteration.

Also, given that this module isn't likely to provide anything on
older platforms, it should get loaded only on newer platforms.

Thanks
Dipankar
