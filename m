Return-Path: <nfont@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EAEA7B7C21
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 03:47:26 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA2GeUHt024111
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2009 09:40:30 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id nA2GlBAv115914
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2009 09:47:12 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nA2GlA2p013022
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Nov 2009 09:47:10 -0700
Message-ID: <4AEF0D0B.1000100@austin.ibm.com>
Date: Mon, 02 Nov 2009 10:47:07 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/6 v5] Kernel DLPAR Infrastructure
References: <4AE8ADCF.6090104@austin.ibm.com> <4AE8AF4D.4030403@austin.ibm.com>
	<1256785731.26770.38.camel@pasglop>
	<4AEF086D.9010600@austin.ibm.com>
	<fa686aa40911020840s3a6a4819g85f3be3a305820bf@mail.gmail.com>
In-Reply-To: <fa686aa40911020840s3a6a4819g85f3be3a305820bf@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Mon, Nov 2, 2009 at 9:27 AM, Nathan Fontenot <nfont@austin.ibm.com> wrote:
>> I saw that Grant Likely is doing updates to all of the of_* stuff right now,
>> would it be ok to have these routines here, renamed as dlpar_*, and look
>> to merge them in with Grant's updates when he finishes?
> 
> No because then we're stuck with renaming the API at a later date.
> Name it what it is, and put it where it belongs.  I'll deal with any
> merge breakage as it occurs.
> 

ok.  Would this be better off in powerpc code, or should I go ahead and put it
in something like drivers/of/dynamic.c?

-Nathan Fontenot
