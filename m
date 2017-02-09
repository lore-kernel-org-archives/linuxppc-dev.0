Return-Path: <laurentiu.tudor@nxp.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10042.outbound.protection.outlook.com [40.107.1.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vK04k1MR7zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:57:09 +1100 (AEDT)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Thomas De Schampheleire <patrickdepinguin@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: Ronny Meeus <Ronny.Meeus@gmail.com>
Subject: Re: "Unable to handle kernel paging request for instruction fetch" on
 P4080
Date: Thu, 9 Feb 2017 13:57:02 +0000
Message-ID: <589C752E.4070507@nxp.com>
References: <CAAXf6LWL67Qvdv82yOREoB5Q5fVHNUU3m5a13-qSowk30Oj8AA@mail.gmail.com>
 <CAAXf6LVrPi+8dHu75Oy1UBgd8kRk=uEzWTVTJB5yN=X6kq5ixQ@mail.gmail.com>
In-Reply-To: <CAAXf6LVrPi+8dHu75Oy1UBgd8kRk=uEzWTVTJB5yN=X6kq5ixQ@mail.gmail.com>
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

SGkgVGhvbWFzLA0KDQpPbiAwMi8wMS8yMDE3IDExOjQ2IEFNLCBUaG9tYXMgRGUgU2NoYW1waGVs
ZWlyZSB3cm90ZToNCj4gT24gV2VkLCBKYW4gMjUsIDIwMTcgYXQgMTA6NDYgQU0sIFRob21hcyBE
ZSBTY2hhbXBoZWxlaXJlDQo+IDxwYXRyaWNrZGVwaW5ndWluQGdtYWlsLmNvbT4gd3JvdGU6DQo+
PiBIaSwNCj4+DQo+PiBXZSBhcmUgZXhwZXJpZW5jaW5nIGtlcm5lbCBwYW5pY3Mgb2YgdGhlIHR5
cGUgIlVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZw0KPj4gcmVxdWVzdCBmb3IgaW5zdHJ1
Y3Rpb24gZmV0Y2giIGJ1dCBhcmUgc3R1Y2sgaW4gb3VyIGFuYWx5c2lzLiBXZSB3b3VsZA0KPj4g
YXBwcmVjaWF0ZSBhbnkgaGVscCB5b3UgY2FuIGdpdmUuDQo+Pg0KPj4gVGhlIHByb2JsZW0gb2Nj
dXJzIGZyb20gdGltZSB0byB0aW1lIG9uIGRpZmZlcmVudCBpbnN0YW5jZXMgb2YgYSBwYXJ0aWN1
bGFyDQo+PiBlbWJlZGRlZCBzeXN0ZW1zLiBUaGUga2VybmVsIGlzIHZlcnkgb2xkLCAyLjYuMzYu
NCwgYW5kIHJ1bnMgb24gYW4gOC1jb3JlDQo+PiBGcmVlc2NhbGUgUDQwODAgUW9ySVEgcHJvY2Vz
c29yIChlNTAwbWMtYmFzZWQpLiBVcGdyYWRpbmcgdGhlIGtlcm5lbCB0byBhIG5ld2VyDQo+PiB2
ZXJzaW9uIGlzIG5vdCBhbiBvcHRpb24gYXQgdGhpcyBwb2ludC4NCg0KQW55IGNoYW5jZSBvZiBh
dCBsZWFzdCB0cnlpbmcgYSBuZXdlciBrZXJuZWwganVzdCB0byBjaGVjayBpZiB0aGUgaXNzdWUN
CndhcyBmaXhlZCBpbiB0aGUgbWVhbnRpbWUuIEFsc28sIHRyeWluZyBhIG5ld2VyIHUtYm9vdCBt
aWdodCBoZWxwLg0KQW5vdGhlciB0aGluZzogY2FuIHlvdSB0cnkgYm9vdGluZyBvbiBvbmUgY29y
ZSBvbmx5Pw0KDQotLS0NCkJlc3QgUmVnYXJkcywgTGF1cmVudGl1
