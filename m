Return-Path: <mohan@in.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 346B8474C2
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 04:36:43 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m91IaLeX009075
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 14:36:21 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m91IaLnd062868
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 12:36:21 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m91IaLud001948
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 12:36:21 -0600
Message-ID: <48E3C318.3040507@in.ibm.com>
Date: Thu, 02 Oct 2008 00:06:08 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] Remove legacy kdump kernel build support
References: <20080930124828.GA1945@in.ibm.com>
	<20080930172540.GA21378@oksana.dev.rtsoft.ru>
In-Reply-To: <20080930172540.GA21378@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Tue, Sep 30, 2008 at 06:18:28PM +0530, Mohan Kumar M wrote:
>> Remove legacy kdump kernel build support
>>

Hi,

I have submitted the patch to support relocatable kdump kernel with 
retaining legacy kdump build support.

Regards,
Mohan.

> 
> Can we leave the legacy support for a while? On PPC32 we don't have
> the relocatable kernel support, but we have kdump patches floating
> around[1], and they use the `hard-coded values' approach, so far.
> 
> I'm not sure if anybody is currently working on a PPC32 kernel
> relocation support.. but for sure it will take some time to implement.
> 
> Thanks,
> 
> [1] http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061161.html
> 
