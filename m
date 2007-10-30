Return-Path: <Gerald.VanBaren@ge.com>
Received: from ext-nj2ut-12.online-age.net (ext-nj2ut-12.online-age.net
	[64.14.54.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8F424DE332
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 04:20:17 +1100 (EST)
Received: from int-nj2ut-5.online-age.net (int-nj2ut-5.online-age.net
	[3.159.237.74])
	by ext-nj2ut-12.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id l9UHE81l030426
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 13:14:08 -0400
Received: from cinmlef03.e2k.ad.ge.com (int-nj2ut-5.online-age.net
	[3.159.237.74])
	by int-nj2ut-5.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id l9UHE7Ow012753
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 13:14:08 -0400
Message-ID: <4727665E.1070109@ge.com>
Date: Tue, 30 Oct 2007 13:14:06 -0400
From: Jerry Van Baren <gerald.vanbaren@ge.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: libfdt as its own repo and submodule of dtc?
References: <C98039BC-92DE-4398-B198-EDAD12A3670C@kernel.crashing.org>
	<E1ImtSB-0003vC-0j@jdl.com>
In-Reply-To: <E1ImtSB-0003vC-0j@jdl.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> So, like, the other day Kumar Gala mumbled:
>> Jon,
>>
>> It seems like have libfdt as a unique git repo that is a submodule of  
>> the things that need it (dtc, u-boot, etc.) might make some sense and  
>> it easier for the projects that need to pull it in.
>>
>> Is this something you can take a look at? (or have other ideas on).
> 
> I would be fine with making libfdt a git repository separate
> from the DTC repository if that makes it easier to integrate
> it with other projects.
> 
> jdl

That sounds like a good idea to me.  I would really prefer pulling 
patches out of a libfdt repo into the u-boot repo rather than trying to 
kerchunk upgrade lumps.  While we can do this with a dtc repo, it 
potentially makes it a lot more difficult.

gvb
