Return-Path: <Shaohui.Xie@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E102B2C010A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 12:51:52 +1100 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: Scott Wood <scottwood@freescale.com>, "shh.xie@gmail.com"
 <shh.xie@gmail.com>
Subject: RE: [PATCH 1/4] phylib: Add Clause 45 read/write functions
Date: Wed, 13 Nov 2013 01:51:45 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C91512489F@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1384167864-2457-1-git-send-email-shh.xie@gmail.com>
 <1384293487.1403.67.camel@snotra.buserror.net>
In-Reply-To: <1384293487.1403.67.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Shruti Kanetkar <Shruti@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Madalin-Cristian Bucur <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0K
PiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEzLCAyMDEzIDU6NTggQU0NCj4gVG86IHNoaC54
aWVAZ21haWwuY29tDQo+IENjOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgS2FuZXRrYXINCj4gU2hydXRpLUI0NDQ1NDsgWGllIFNo
YW9odWktQjIxOTg5OyBCdWN1ciBNYWRhbGluLUNyaXN0aWFuLUIzMjcxNg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDEvNF0gcGh5bGliOiBBZGQgQ2xhdXNlIDQ1IHJlYWQvd3JpdGUgZnVuY3Rpb25z
DQo+IA0KPiBPbiBNb24sIDIwMTMtMTEtMTEgYXQgMTk6MDQgKzA4MDAsIHNoaC54aWVAZ21haWwu
Y29tIHdyb3RlOg0KPiA+IEZyb206IEFuZHkgRmxlbWluZw0KPiA+DQo+ID4gWW91IG5lZWQgYW4g
ZXh0cmEgcGFyYW1ldGVyIHRvIHJlYWQgb3Igd3JpdGUgQ2xhdXNlIDQ1IFBIWXMsIHNvIHdlDQo+
ID4gbmVlZCBhIGRpZmZlcmVudCBBUEkgd2l0aCB0aGUgZXh0cmEgcGFyYW1ldGVyLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogQW5keSBGbGVtaW5nDQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhb2h1
aSBYaWUgPFNoYW9odWkuWGllQGZyZWVzY2FsZS5jb20+DQo+IA0KPiBXaHkgZGlkIHlvdSByZW1v
dmUgQW5keSdzIGUtbWFpbCBhZGRyZXNzPyAgRXZlbiB0aG91Z2ggaXQncyBubyBsb25nZXIgdmFs
aWQsIGl0DQo+IGhlbHBzIGlkZW50aWZ5IHdoaWNoIHNwZWNpZmljIHBlcnNvbiB5b3UncmUgdGFs
a2luZyBhYm91dC4NCj4gDQpbUy5IXSBBbmR5J3MgZS1tYWlsIGFkZHJlc3MgaXMgbm90IHZhbGlk
IGFuZCBnaXQtc2VuZC1tYWlsIHdpbGwgZmFpbCwgSSBoYXZlIHRvIHJlbW92ZSBpdCB0byBtYWtl
IGdpdCB3b3JrLg0KDQoNCkJlc3QgUmVnYXJkcywgDQpTaGFvaHVpIFhpZQ0K
