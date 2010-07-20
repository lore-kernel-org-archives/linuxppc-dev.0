Return-Path: <dave@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC2291007D9
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 05:23:21 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6KJ6wMn026785
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 15:06:58 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6KJNIG9288266
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 15:23:18 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6KJN5Dp012564
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 13:23:06 -0600
Subject: Re: [PATCH 8/8] v3 Update memory-hotplug documentation
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4C451F3F.8000207@austin.ibm.com>
References: <4C451BF5.50304@austin.ibm.com> <4C451F3F.8000207@austin.ibm.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Tue, 20 Jul 2010 12:23:04 -0700
Message-ID: <1279653784.9785.6.camel@nimitz>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, greg@kroah.com, linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-07-19 at 22:59 -0500, Nathan Fontenot wrote:
> 
> 
> -Now, XXX is defined as start_address_of_section / section_size.
> +Now, XXX is defined as (start_address_of_section / section_size) of
> the first
> +section conatined in the memory block.
> 
>  For example, assume 1GiB section size. A device for a memory starting
> at
>  0x100000000 is /sys/device/system/memory/memory4
>  (0x100000000 / 1Gib = 4)
>  This device covers address range [0x100000000 ... 0x140000000)
> 
> -Under each section, you can see 4 files.
> +Under each section, you can see 5 files.
> 
> -/sys/devices/system/memory/memoryXXX/phys_index
> +/sys/devices/system/memory/memoryXXX/start_phys_index
> +/sys/devices/system/memory/memoryXXX/end_phys_index 

Just wanted to make sure you didn't forget to update this after KAME's
comments on the first couple of patches.


-- Dave
