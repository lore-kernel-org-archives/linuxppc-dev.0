Return-Path: <Pavel.Tatashin@microsoft.com>
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720138.outbound.protection.outlook.com [40.107.72.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421XqF0kyXzF37N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 05:38:48 +1000 (AEST)
From: Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To: David Hildenbrand <david@redhat.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Jonathan
 Corbet <corbet@lwn.net>, Michal Hocko <mhocko@suse.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH RFCv2 6/6] memory-hotplug.txt: Add some details about
 locking internals
Date: Thu, 30 Aug 2018 19:38:43 +0000
Message-ID: <b46f358b-8fea-b380-1978-5f3e772130d4@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-7-david@redhat.com>
In-Reply-To: <20180821104418.12710-7-david@redhat.com>
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

DQpSZXZpZXdlZC1ieTogUGF2ZWwgVGF0YXNoaW4gPHBhdmVsLnRhdGFzaGluQG1pY3Jvc29mdC5j
b20+DQoNCk9uIDgvMjEvMTggNjo0NCBBTSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+IExl
dCdzIGRvY3VtZW50IHRoZSBtYWdpYyBhIGJpdCwgZXNwZWNpYWxseSB3aHkgZGV2aWNlX2hvdHBs
dWdfbG9jayBpcw0KPiByZXF1aXJlZCB3aGVuIGFkZGluZy9yZW1vdmluZyBtZW1vcnkgYW5kIGhv
dyBpdCBhbGwgcGxheSB0b2dldGhlciB3aXRoDQo+IHJlcXVlc3RzIHRvIG9ubGluZS9vZmZsaW5l
IG1lbW9yeSBmcm9tIHVzZXIgc3BhY2UuDQo+IA==
