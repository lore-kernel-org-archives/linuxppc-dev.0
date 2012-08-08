Return-Path: <B38951@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4857C2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 19:39:24 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Wed, 8 Aug 2012 09:39:15 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A51913@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-4-git-send-email-B38951@freescale.com>
 <501BFC0E.6070708@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A36D0A@039-SN1MPN1-002.039d.mgd.msft.net>
 <501FDE40.1060906@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A45931@039-SN1MPN1-002.039d.mgd.msft.net>
 <50213439.9070806@freescale.com>
In-Reply-To: <50213439.9070806@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDA3LCAyMDEyIDExOjI5IFBNDQo+IFRvOiBKaWEg
SG9uZ3Rhby1CMzg5NTENCj4gQ2M6IFdvb2QgU2NvdHQtQjA3NDIxOyBsaW51eHBwYy1kZXZAbGlz
dHMub3psYWJzLm9yZzsNCj4gZ2FsYWtAa2VybmVsLmNyYXNoaW5nLm9yZzsgTGkgWWFuZy1SNTg0
NzINCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNSAzLzNdIHBvd2VycGMvZnNsLXBjaTogVW5pZnkg
cGNpL3BjaWUNCj4gaW5pdGlhbGl6YXRpb24gY29kZQ0KPiANCj4gT24gMDgvMDcvMjAxMiAwMzow
OSBBTSwgSmlhIEhvbmd0YW8tQjM4OTUxIHdyb3RlOg0KPiA+IEkgYW0gcmVhbGx5IG5vdCBzdXJl
IHRoYXQgYWxsIGJvYXJkcyBuZWVkIHByaW1hcnkgYnVzLiBDb3VsZCB5b3UgZ2l2ZQ0KPiA+IG1l
IHRoZSBsaW5rIG9mIGRpc2N1c3Npb24gYWJvdXQgcHJpbWFyeSB0aGF0IHlvdSBtZW50aW9uZWQ/
DQo+IA0KPiBodHRwczovL2xpc3RzLm96bGFicy5vcmcvcGlwZXJtYWlsL2xpbnV4cHBjLWRldi8y
MDEyLUp1bmUvMDk4NTg2Lmh0bWwNCj4gDQo+IC1TY290dA0KDQoNCkl0IHNlZW1zIGluIHFlbXUg
aXNhX2lvX2Jhc2UgbXVzdCBiZSBub24temVyby4NCklmIHRoZXJlIGlzIG5vIGlzYSBicmlkZ2Ug
c2hvdWxkIGlzYV9pb19iYXNlIGJlIG5vbi16ZXJvIGZvciBvdGhlciBib2FyZHM/DQpJZiBub3Qg
bWF5YmUgd2Ugc2hvdWxkIGZpeCBxZW11IGJ1Zy4NCk9yICJxdWljayBmaXgiIGluIHRoZSBsaW5r
IGlzIGEgd29ya2Fyb3VuZC4NCg0KLUhvbmd0YW8uDQo=
