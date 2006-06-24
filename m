Return-Path: <jdl@jdl.com>
Received: from jdl.com (colo.jdl.com [66.118.10.122])
	by ozlabs.org (Postfix) with ESMTP id E957867A3E
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jun 2006 02:22:17 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1FuAte-0005jA-IX
	for linuxppc-dev@ozlabs.org; Sat, 24 Jun 2006 11:22:11 -0500
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 5/6] CPM_UART: unify clock sources 
In-Reply-To: Your message of "Sat, 24 Jun 2006 19:21:36 +0400."
	<20060624192136.41e9987d@localhost.localdomain>
References: <20060623231648.6721.3495.stgit@localhost.localdomain>
	<20060623231707.6721.43277.stgit@localhost.localdomain>
	<10C0FB27-7351-4578-9CE5-3EFA476C2661@kernel.crashing.org>
	<20060624192136.41e9987d@localhost.localdomain>
Date: Sat, 24 Jun 2006 11:22:10 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FuAte-0005jA-IX@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Vitaly Bordug mumbled:
> That was my first guess as well, but: 
> The aim is yet moving to powerpc not to break existing ppc/ stuff. 
> So if alternatively platform_data may be utilized, all relevant ppc
> stuff that uses cpm uart should be updated. While doing the driver
> "platformize" trick, I made it possible to keep legacy behaviour
> (pd-less), this is not going to afford such a thing. 
> 
> IOW, I don't see much sense in updating ppc/ BSP files, just to keep
> the right way. It does not look very neat now, but does the job of
> moving FW and keeping existing stuff sane. If there is better approach
> envisioned, I'll definitely follow..

And don't forget that the subsequent, follow-up patches
will be to _remove_ the 85xx family from arch/ppc as well.
The trick right now is simply to get it working in arch/powerpc
so that we can move forward there.  Worrying about absolute
cleanliness in arch/ppc for 85xx shouldn't, in my opinion,
be the highest concern.

Thanks,
jdl
