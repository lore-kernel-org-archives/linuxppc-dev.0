Return-Path: <Pavel.Tatashin@microsoft.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0716.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421Rrc1FwvzF374
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 01:54:39 +1000 (AEST)
From: Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To: David Hildenbrand <david@redhat.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Andrew Morton
 <akpm@linux-foundation.org>, Balbir Singh <bsingharora@gmail.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, John
 Allen <jallen@linux.vnet.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Joonsoo
 Kim <iamjoonsoo.kim@lge.com>, Juergen Gross <jgross@suse.com>, Kate Stewart
 <kstewart@linuxfoundation.org>, KY Srinivasan <kys@microsoft.com>, Len Brown
 <lenb@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mathieu
 Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>, Michael
 Neuling <mikey@neuling.org>, Michal Hocko <mhocko@suse.com>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>, Oscar Salvador <osalvador@suse.de>, Paul
 Mackerras <paulus@samba.org>, Philippe Ombredanne <pombredanne@nexb.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rashmica Gupta
 <rashmica.g@gmail.com>, Stephen Hemminger <sthemmin@microsoft.com>, Thomas
 Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, YASUAKI
 ISHIMATSU <yasu.isimatu@gmail.com>
Subject: Re: [PATCH RFCv2 0/6] mm: online/offline_pages called w.o.
 mem_hotplug_lock
Date: Thu, 30 Aug 2018 15:54:30 +0000
Message-ID: <b9eb96e7-3846-1aaa-d257-895ca142b1ef@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <37ea507e-b16d-ae8d-4da8-128b621869f2@redhat.com>
In-Reply-To: <37ea507e-b16d-ae8d-4da8-128b621869f2@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCk9uIDgvMzAvMTggODozMSBBTSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+IE9uIDIx
LjA4LjIwMTggMTI6NDQsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4gVGhpcyBpcyB0aGUg
c2FtZSBhcHByb2FjaCBhcyBpbiB0aGUgZmlyc3QgUkZDLCBidXQgdGhpcyB0aW1lIHdpdGhvdXQN
Cj4+IGV4cG9ydGluZyBkZXZpY2VfaG90cGx1Z19sb2NrIChyZXF1ZXN0ZWQgYnkgR3JlZykgYW5k
IHdpdGggc29tZSBtb3JlDQo+PiBkZXRhaWxzIGFuZCBkb2N1bWVudGF0aW9uIHJlZ2FyZGluZyBs
b2NraW5nLiBUZXN0ZWQgb25seSBvbiB4ODYgc28gZmFyLg0KPj4NCj4gDQo+IEknbGwgYmUgb24g
dmFjYXRpb24gZm9yIHR3byB3ZWVrcyBzdGFydGluZyBvbiBTYXR1cmRheS4gSWYgdGhlcmUgYXJl
IG5vDQo+IGNvbW1lbnRzIEknbGwgc2VuZCB0aGlzIGFzICFSRkMgb25jZSBJIHJldHVybi4NCj4N
CkkgYW0gc3R1ZHlpbmcgdGhpcyBzZXJpZXMsIHdpbGwgc2VuZCBteSBjb21tZW50cyBsYXRlciB0
b2RheS4NCg0KUGF2ZWw=
