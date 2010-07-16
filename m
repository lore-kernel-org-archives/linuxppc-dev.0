Return-Path: <dave@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C8AF1B6F11
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jul 2010 03:18:26 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6GH7Fl4015829
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 11:07:15 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6GHICRC117558
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 11:18:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6GHI9Z7003283
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 11:18:11 -0600
Subject: Re: [PATCH 5/5] v2 Enable multiple sections per directory for ppc
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4C3F5668.2060407@austin.ibm.com>
References: <4C3F53D1.3090001@austin.ibm.com> <4C3F5668.2060407@austin.ibm.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Fri, 16 Jul 2010 10:18:08 -0700
Message-ID: <1279300688.9207.224.camel@nimitz>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-15 at 13:41 -0500, Nathan Fontenot wrote:
>  linux-2.6.orig/arch/powerpc/platforms/pseries/hotplug-memory.c      2010-07-15 09:54:06.000000000 -0500
> +++ linux-2.6/arch/powerpc/platforms/pseries/hotplug-memory.c   2010-07-15 09:56:19.000000000 -0500
> @@ -17,6 +17,54 @@
>  #include <asm/pSeries_reconfig.h>
>  #include <asm/sparsemem.h>
> 
> +static u32 get_memblock_size(void)
> +{
> +       struct device_node *np;
> +       unsigned int memblock_size = 0;
> + 

Please give this sucker some units.  get_memblock_size_bytes()?
get_memblock_size_in_g0ats()?


-- Dave
