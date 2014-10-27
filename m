Return-Path: <Yuantian.Tang@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D0D41A006B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 14:54:27 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0103.outbound.protection.outlook.com [157.56.111.103])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1E3F4140081
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2014 14:54:25 +1100 (AEDT)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: RE: [PATCH] cpufreq: qoriq: Make the driver usable on all QorIQ
 platforms
Date: Mon, 27 Oct 2014 03:39:40 +0000
Message-ID: <c94b68be09dd4bfaa8a80d9877362fb5@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1413515616-15874-1-git-send-email-B29983@freescale.com>
 <CAKohpokotKSvQ13uU4MnCer+qzBUUbGVTd19y7xswCAEKk3nGQ@mail.gmail.com>
 <6aaa50ef5f234fe2896f1c66eb646dfb@DM2PR03MB574.namprd03.prod.outlook.com>
 <CAKohpokSuKOwZ3-OWFtU0z7E1fsMg4tyPiUoFUfw26pD9Py=MA@mail.gmail.com>
In-Reply-To: <CAKohpokSuKOwZ3-OWFtU0z7E1fsMg4tyPiUoFUfw26pD9Py=MA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVzaCBLdW1hciBbbWFp
bHRvOnZpcmVzaC5rdW1hckBsaW5hcm8ub3JnXQ0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIx
LCAyMDE0IDU6MDQgUE0NCj4gVG86IFRhbmcgWXVhbnRpYW4tQjI5OTgzDQo+IENjOiBSYWZhZWwg
Si4gV3lzb2NraTsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdDsgbGludXgtcG1Admdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eHBwYy1kZXZAb3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBjcHVmcmVxOiBxb3JpcTogTWFrZSB0aGUgZHJpdmVyIHVzYWJsZSBvbiBhbGwgUW9ySVENCj4g
cGxhdGZvcm1zDQo+IA0KPiBPbiAyMSBPY3RvYmVyIDIwMTQgMTQ6MjksIFl1YW50aWFuIFRhbmcg
PFl1YW50aWFuLlRhbmdAZnJlZXNjYWxlLmNvbT4NCj4gd3JvdGU6DQo+ID4gSWYgSSBkbyBzbywg
bWVudWNvbmZpZyB3aWxsIGRpc3BsYXkgbGlrZSB0aGlzKG9uIFBQQyk6DQo+ID4gICAgICAgICBQ
b3dlclBDIENQVSBmcmVxdWVuY3kgc2NhbGluZyBkcml2ZXJzICAtLS0tDQo+ID4gICAgIFFvcklR
IENQVSBGcmVxdWVuY3kgc2NhbGluZyAgLS0tPg0KPiA+ICAgICAgICAgICAgICAgICA8Kj4gQ1BV
IGZyZXF1ZW5jeSBzY2FsaW5nIGRyaXZlciBmb3IgRnJlZXNjYWxlIFFvcklRDQo+ID4gU29DcyBP
biBBUk0sIHRoZXJlIHNob3VsZCBiZSBhIHNpbWlsYXIgcHJvYmxlbS4NCj4gPiBJc24ndCB3ZWly
ZD8NCj4gDQo+IFNpbWlsYXIgaXMgdHJ1ZSBmb3IgY3B1ZnJlcS1jcHUwIGRyaXZlciBhcyB3ZWxs
Li4gTWF5YmUgd2UgY2FuIGNyZWF0ZSBhDQo+IEtjb25maWcuZHJpdmVycyBjb25maWd1cmF0aW9u
IGFuZCBpbmNsdWRlIGl0IGZyb20gYWxsIGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBvbmVzID8NCj4g
DQo+IEAgUmFmYWVsID8NCg0KRG8gd2UgaGF2ZSBhIGNvbmNsdXNpb24geWV0Pw0KDQpSZWdhcmRz
LA0KWXVhbnRpYW4NCg==
