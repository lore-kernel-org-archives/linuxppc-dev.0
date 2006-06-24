Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43E2C67AA0
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jun 2006 02:27:36 +1000 (EST)
In-Reply-To: <E1FuAte-0005jA-IX@jdl.com>
References: <20060623231648.6721.3495.stgit@localhost.localdomain>
	<20060623231707.6721.43277.stgit@localhost.localdomain>
	<10C0FB27-7351-4578-9CE5-3EFA476C2661@kernel.crashing.org>
	<20060624192136.41e9987d@localhost.localdomain>
	<E1FuAte-0005jA-IX@jdl.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C156EF12-05E0-4DA5-8625-ED6201F2512B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/6] CPM_UART: unify clock sources 
Date: Sat, 24 Jun 2006 11:27:31 -0500
To: Jon Loeliger <jdl@jdl.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 24, 2006, at 11:22 AM, Jon Loeliger wrote:

> So, like, the other day Vitaly Bordug mumbled:
>> That was my first guess as well, but:
>> The aim is yet moving to powerpc not to break existing ppc/ stuff.
>> So if alternatively platform_data may be utilized, all relevant ppc
>> stuff that uses cpm uart should be updated. While doing the driver
>> "platformize" trick, I made it possible to keep legacy behaviour
>> (pd-less), this is not going to afford such a thing.
>>
>> IOW, I don't see much sense in updating ppc/ BSP files, just to keep
>> the right way. It does not look very neat now, but does the job of
>> moving FW and keeping existing stuff sane. If there is better  
>> approach
>> envisioned, I'll definitely follow..
>
> And don't forget that the subsequent, follow-up patches
> will be to _remove_ the 85xx family from arch/ppc as well.
> The trick right now is simply to get it working in arch/powerpc
> so that we can move forward there.  Worrying about absolute
> cleanliness in arch/ppc for 85xx shouldn't, in my opinion,
> be the highest concern.

Its a concern until we have a way of booting existing 85xx systems w/ 
their boot loaders using arch/powerpc kernels.

Also, CPM effects more than just 85xx so care needs to be taken for  
8xx & 82xx.

- k
