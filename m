Return-Path: <B29983@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2ABB2C00F7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2013 13:17:02 +1100 (EST)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: RE: [PATCH v3] cpufreq: Add cpufreq driver for Freescale e500mc SoCs
Date: Mon, 1 Apr 2013 02:16:55 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B0B122EF7@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1364536350-23788-1-git-send-email-Yuantian.Tang@freescale.com>
 <CAOh2x=k2cchYWnX0AitOjCOfP_mC-=cm2sm4qhrGv0S9ywzP2g@mail.gmail.com>
In-Reply-To: <CAOh2x=k2cchYWnX0AitOjCOfP_mC-=cm2sm4qhrGv0S9ywzP2g@mail.gmail.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>,
 Linux PM list <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNwdWZyZXEtb3duZXJAdmdl
ci5rZXJuZWwub3JnIFttYWlsdG86Y3B1ZnJlcS1vd25lckB2Z2VyLmtlcm5lbC5vcmddDQo+IE9u
IEJlaGFsZiBPZiBWaXJlc2ggS3VtYXINCj4gU2VudDogMjAxM8TqM9TCMzDI1SAyMTo1Mg0KPiBU
bzogVGFuZyBZdWFudGlhbi1CMjk5ODMNCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpOyBjcHVmcmVx
QHZnZXIua2VybmVsLm9yZzsgTGludXggUE0gbGlzdDsgbGludXhwcGMtDQo+IGRldkBsaXN0cy5v
emxhYnMub3JnOyBMaSBZYW5nLVI1ODQ3Mg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBjcHVm
cmVxOiBBZGQgY3B1ZnJlcSBkcml2ZXIgZm9yIEZyZWVzY2FsZSBlNTAwbWMNCj4gU29Dcw0KPiAN
Cj4gT24gRnJpLCBNYXIgMjksIDIwMTMgYXQgMTE6MjIgQU0sICA8WXVhbnRpYW4uVGFuZ0BmcmVl
c2NhbGUuY29tPiB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL3BwYy1j
b3JlbmV0LWNwdWZyZXEuYw0KPiA+IGIvZHJpdmVycy9jcHVmcmVxL3BwYy1jb3JlbmV0LWNwdWZy
ZXEuYw0KPiANCj4gPiArc3RhdGljIGludCBjb3JlbmV0X2NwdWZyZXFfY3B1X2luaXQoc3RydWN0
IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpIHsNCj4gDQo+ID4gKyAgICAgICBmb3IgKGkgPSAwOyBp
IDwgY291bnQ7IGkrKykgew0KPiA+ICsgICAgICAgICAgICAgICB0YWJsZVtpXS5pbmRleCA9IGk7
DQo+IA0KPiBPbmUgbW9yZSB0aGluZywgeW91IGRvbid0IG5lZWQgdG8gc2V0IGluZGV4IGF0IGFs
bCBhcyB5b3UgYXJlbid0IHVzaW5nIGl0Lg0KPiBBbmQgY3B1ZnJlcSBjb3JlIG5ldmVyIHVzZXMg
aXQuDQo+IA0KT0ssIG5vIHByb2JsZW0uDQoNClRoYW5rcywNCll1YW50aWFuDQoNCj4gPiArICAg
ICAgICAgICAgICAgY2xrID0gb2ZfY2xrX2dldChkYXRhLT5wYXJlbnQsIGkpOw0KPiA+ICsgICAg
ICAgICAgICAgICB0YWJsZVtpXS5mcmVxdWVuY3kgPSBjbGtfZ2V0X3JhdGUoY2xrKSAvIDEwMDA7
DQo+ID4gKyAgICAgICB9DQo+IC0tDQo+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBz
ZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmliZSBjcHVmcmVxIiBpbiB0aGUNCj4gYm9keSBvZiBhIG1l
c3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVsLm9yZyBNb3JlIG1ham9yZG9tbyBpbmZvIGF0
DQo+IGh0dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA0KDQo=
