Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0137.outbound.protection.outlook.com [65.55.169.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 650A51A035C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 12:15:53 +1000 (AEST)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Huan Wang
 <alison.wang@freescale.com>, Jin Jason <Jason.Jin@freescale.com>, Zhao C.H.
 <chenhui.zhao@freescale.com>, Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: RE: [PATCH v2 1/2] fsl: Add binding for RCPM
Date: Wed, 16 Sep 2015 02:15:45 +0000
Message-ID: <SN1PR0301MB1616C48FB3D990BCA45289AB9D5B0@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1442307339-15225-1-git-send-email-dongsheng.wang@freescale.com>
 <1442361398.2909.164.camel@freescale.com>
In-Reply-To: <1442361398.2909.164.camel@freescale.com>
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

SGkgU2NvdHQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBT
Y290dC1CMDc0MjENCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMTUgNzo1NyBB
TQ0KPiBUbzogV2FuZyBEb25nc2hlbmctQjQwNTM0DQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7DQo+IHJvYmgrZHRAa2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBXYW5nIEh1YW4tQjE4
OTY1OyBKaW4NCj4gWmhlbmd4aW9uZy1SNjQxODg7IFpoYW8gQ2hlbmh1aS1CMzUzMzY7IFRhbmcg
WXVhbnRpYW4tQjI5OTgzDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8yXSBmc2w6IEFkZCBi
aW5kaW5nIGZvciBSQ1BNDQo+IA0KPiBPbiBUdWUsIDIwMTUtMDktMTUgYXQgMTY6NTUgKzA4MDAs
IERvbmdzaGVuZyBXYW5nIHdyb3RlOg0KPiA+ICsqIEZyZWVzY2FsZSBSQ1BNIFdha2V1cCBTb3Vy
Y2UgRGV2aWNlIFRyZWUgQmluZGluZ3MNCj4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICtSZXF1aXJlZCByY3BtLXdha2V1cCBwcm9wZXJ0eSBzaG91
bGQgYmUgYWRkZWQgdG8gYSBkZXZpY2Ugbm9kZSBpZiB0aGUNCj4gPiBkZXZpY2UNCj4gPiArY2Fu
IGJlIHVzZWQgYXMgYSB3YWtldXAgc291cmNlLg0KPiA+ICsNCj4gPiArICAtIHJjcG0td2FrZXVw
OiBUaGUgdmFsdWUgb2YgdGhlIHByb3BlcnR5IGNvbnNpc3RzIG9mIDMgY2VsbHMuIFRoZSBmaXJz
dA0KPiA+IGNlbGwNCj4gPiArICAgICBpcyBhIHBvaW50ZXIgdG8gdGhlIHJjcG0gbm9kZSwgdGhl
IHNlY29uZCBjZWxsIGlzIHRoZSBiaXQgbWFzayB0aGF0DQo+ID4gKyAgICAgc2hvdWxkIGJlIHNl
dCBpbiBJUFBERVhQQ1IwLCBhbmQgdGhlIGxhc3QgY2VsbCBpcyBmb3IgSVBQREVYUENSMS4NCj4g
PiArICAgICBOb3RlOiBJZiB0aGUgcGxhdGZvcm0gaGFzIG5vIElQUERFWFBDUjEgcmVnaXN0ZXIs
IHB1dCBhIHplcm8gaGVyZS4NCj4gDQo+IFdoYXQgaWYgYSBmdXR1cmUgcGxhdGZvcm0gaGFzIG1v
cmUgdGhhbiB0d28gb2YgdGhlc2UgcmVnaXN0ZXJzPw0KDQpUaG9zZSByZWdpc3RlcnMgYXJlIG9u
bHkgdXNlZCBmb3Igd2FrZXVwIGRldmljZSwgd2UgaGF2ZSBhIGxvdCBvZiBhdmFpbGFibGUgYml0
DQpmb3IgZmVhdHVyZS4gRm9yIGV4YW1wbGUsIEluIExTMTAyMWEgcGxhdGZvcm0gb25seSA3Yml0
cyBoYXMgdXNlZCBpbiB0aGUgcmVnaXN0ZXJzLA0KYW5kIDU3Yml0cyBpcyByZXNlcnZlZC4NCg0K
UmVnYXJkcywNCi1Eb25nc2hlbmcNCg==
