Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.182])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45DF61A078D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2015 01:19:10 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Stephen Rothwell' <sfr@canb.auug.org.au>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: RE: [PATCHv2] powerpc: comvert relocs_check to a shell script using
 grep
Date: Fri, 13 Mar 2015 14:18:10 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CAFEAE2@AcuExch.aculab.com>
References: <20150313131949.3e9d2b11@canb.auug.org.au>
In-Reply-To: <20150313131949.3e9d2b11@canb.auug.org.au>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogU3RlcGhlbiBSb3Rod2VsbA0KPiBUaGlzIHJ1bnMgYSBiaXQgZmFzdGVyIGFuZCByZW1v
dmVzIGFub3RoZXIgdXNlIG9mIHBlcmwgZnJvbQ0KPiB0aGUga2VybmVsIGJ1aWxkLg0KLi4uDQo+
IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvcmVsb2NzX2NoZWNrLnNoIGIvYXJjaC9wb3dlcnBj
L3JlbG9jc19jaGVjay5zaA0KPiBuZXcgZmlsZSBtb2RlIDEwMDc1NQ0KPiBpbmRleCAwMDAwMDAw
MDAwMDAuLjE4MmVhZTljYzQwZA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2FyY2gvcG93ZXJw
Yy9yZWxvY3NfY2hlY2suc2gNCj4gQEAgLTAsMCArMSw1OSBAQA0KPiArIyEvYmluL3NoDQouLi4N
Cj4gK2lmIFsgJHsjKn0gLWx0IDIgXTsgdGhlbg0KPiArCWVjaG8gIiQwIFtwYXRoIHRvIG9iamR1
bXBdIFtwYXRoIHRvIHZtbGludXhdIiAxPiYyDQo+ICsJZXhpdCAxDQo+ICtmaQ0KPiArDQo+ICsj
IEhhdmUgS2J1aWxkIHN1cHBseSB0aGUgcGF0aCB0byBvYmpkdW1wIHNvIHdlIGhhbmRsZSBjcm9z
cyBjb21waWxhdGlvbi4NCj4gK29iamR1bXA9IiQxIg0KPiArdm1saW51eD0iJDIiDQoNCkknbSBu
b3QgMTAwJSBzdXJlIG9mIHRoZSByZXF1aXJlbWVudHMgb24gL2Jpbi9zaCBmb3Iga2VybmVsIGJ1
aWxkcy4NCkJ1dCAkeyMqfSBpcyBwcm9iYWJseSBub3QgY29tcGxldGVseSBwb3J0YWJsZSAoYW5k
IG1heSBub3QgYmUgc2FmZQ0KaWYgdGhlcmUgYXJlIGVtYmVkZGVkIHNwYWNlcyBpbiB0aGUgYXJn
dW1lbnRzKS4NCg0KTWlnaHQgYmUgYmV0dGVyIHRvIGNoZWNrOg0KCWlmIFsgLXogIiRvYmpkdW1w
IiAtbyAteiAiJHZtbGludXgiIF0NCmluc3RlYWQuDQoNCk9yIGV2ZW46DQoJaWYgWyAhIC14ICIk
b2JqZHVtcCIgLW8gISAtciAiJHZtbGludXgiIF0NCg0KCURhdmlkDQoNCg==
