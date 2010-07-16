Return-Path: <dave@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9ADB2B6F16
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jul 2010 03:16:41 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6GHFfVl000923
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 13:15:41 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6GHGc2M1593456
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 13:16:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6GHGbhU022878
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 13:16:38 -0400
Subject: Re: [PATCH 3/5] v2 Change the mutex name in the memory_block struct
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4C3F55FC.4050205@austin.ibm.com>
References: <4C3F53D1.3090001@austin.ibm.com> <4C3F55FC.4050205@austin.ibm.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Fri, 16 Jul 2010 10:16:35 -0700
Message-ID: <1279300595.9207.223.camel@nimitz>
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

On Thu, 2010-07-15 at 13:39 -0500, Nathan Fontenot wrote:
> 
> Change the name of the memory_block mutex since it is now used for
> more than just gating changes to the status of the memory sections
> covered by the memory sysfs directory.

Heh, sorry about the previous comments. :)

You should move this up to be the first in the series.

-- Dave
