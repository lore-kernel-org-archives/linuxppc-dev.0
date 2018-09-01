Return-Path: <david@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422dJC53N5zF39t
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Sep 2018 00:04:10 +1000 (AEST)
Subject: Re: [PATCH RFCv2 0/6] mm: online/offline_pages called w.o.
 mem_hotplug_lock
To: Oscar Salvador <osalvador@techadventures.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
 devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Juergen Gross <jgross@suse.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>, Michal Hocko <mhocko@suse.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Oscar Salvador <osalvador@suse.de>, Paul Mackerras <paulus@samba.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Rashmica Gupta <rashmica.g@gmail.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180831205457.GB3945@techadventures.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d4b6608b-0b21-b925-4adc-d11e4706f69d@redhat.com>
Date: Sat, 1 Sep 2018 16:03:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180831205457.GB3945@techadventures.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31.08.2018 22:54, Oscar Salvador wrote:
> On Tue, Aug 21, 2018 at 12:44:12PM +0200, David Hildenbrand wrote:
>> This is the same approach as in the first RFC, but this time without
>> exporting device_hotplug_lock (requested by Greg) and with some more
>> details and documentation regarding locking. Tested only on x86 so far.
> 
> Hi David,
> 
> I would like to review this but I am on vacation, so I will not be able to get to it
> soon.
> I plan to do it once I am back.

Sure, I won't be resending within next two weeks either way, as I am
also on vacation.

Have a nice vacation!

> 
> Thanks
> 


-- 

Thanks,

David / dhildenb
