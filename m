Return-Path: <nacc@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2AEFCB70B8
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 06:45:22 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o79Kb00r026019
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Aug 2010 14:37:00 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o79Kiwvx218732
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Aug 2010 14:45:04 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o79KmM3r001305
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Aug 2010 14:48:23 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 8/8] v5  Update memory-hotplug documentation
Date: Mon, 9 Aug 2010 13:44:37 -0700
References: <4C60407C.2080608@austin.ibm.com> <4C604C62.7060509@austin.ibm.com>
In-Reply-To: <4C604C62.7060509@austin.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008091344.37878.nacc@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, August 09, 2010 11:43:46 am Nathan Fontenot wrote:
> Update the memory hotplug documentation to reflect the new behaviors of
> memory blocks reflected in sysfs.

<snip>

> Index: linux-2.6/Documentation/memory-hotplug.txt
> ===================================================================
> --- linux-2.6.orig/Documentation/memory-hotplug.txt	2010-08-09 07:36:48.000000000 -0500
> +++ linux-2.6/Documentation/memory-hotplug.txt	2010-08-09 07:59:54.000000000 -0500

<snip>

> -/sys/devices/system/memory/memoryXXX/phys_index
> +/sys/devices/system/memory/memoryXXX/start_phys_index
> +/sys/devices/system/memory/memoryXXX/end_phys_index
>  /sys/devices/system/memory/memoryXXX/phys_device
>  /sys/devices/system/memory/memoryXXX/state
>  /sys/devices/system/memory/memoryXXX/removable
> 
> -'phys_index' : read-only and contains section id, same as XXX.

<snip>

> +'phys_index'      : read-only and contains section id of the first section

Shouldn't this be "start_phys_index"?

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
Linux Technology Center
