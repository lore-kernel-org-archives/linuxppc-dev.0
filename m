Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id CF8DD140077
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 20:43:48 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 09513-10 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 26 Mar 2014 09:43:45 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Cody P Schafer' <cody@linux.vnet.ibm.com>, Anton Blanchard
 <anton@samba.org>
Subject: RE: [PATCH v4 09/11] powerpc/perf: add support for the hv 24x7
 interface
Date: Wed, 26 Mar 2014 09:43:02 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6E93BC@AcuExch.aculab.com>
References: <1394064082-6242-1-git-send-email-cody@linux.vnet.ibm.com>
 <1394064082-6242-10-git-send-email-cody@linux.vnet.ibm.com>
 <20140325214356.4a2f7d95@kryten> <5331CBB0.8080500@linux.vnet.ibm.com>
In-Reply-To: <5331CBB0.8080500@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michael@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Arnaldo
 Carvalho de Melo <acme@ghostprotocols.net>,
 "scottwood@freescale.com" <scottwood@freescale.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogQ29keSBQIFNjaGFmZXINCj4gT24gMDMvMjUvMjAxNCAwMzo0MyBBTSwgQW50b24gQmxh
bmNoYXJkIHdyb3RlOg0KPiA+DQo+ID4gSGkgQ29keSwNCj4gPg0KPiA+IGh2LTI0eDc6IGNvdWxk
IG5vdCBvYnRhaW4gY2FwYWJpbGl0aWVzLCBlcnJvciAweA0KPiBmZmZmZmZmZmZmZmZmZmZlLCBu
b3QgZW5hYmxpbmcNCj4gPiBodi1ncGNpOiBjb3VsZCBub3Qgb2J0YWluIGNhcGFiaWxpdGllcywg
ZXJyb3IgMHgNCj4gZmZmZmZmZmZmZmZmZmZmZSwgbm90IGVuYWJsaW5nDQo+ID4NCj4gPj4gKwkJ
cHJfaW5mbygiY291bGQgbm90IG9idGFpbiBjYXBhYmlsaXRpZXMsIGVycm9yIDB4JTgwbHgsIG5v
dCBlbmFibGluZ1xuIiwNCj4gPg0KPiA+IFRoYXQncyBhIGxvdCBvZiBwYWRkaW5nIDopDQo+ID4N
Cj4gPiBJIHRoaW5rIHRoaXMgc2hvdWxkIGFsc28gYmUgYSBwcl9kZWJ1ZywgY29uc2lkZXJpbmcg
dGhpcyBpcyBub3QgcmVsZXZhbnQNCj4gPiB0byBtb3N0IHBwYzY0IGJveGVzLg0KPiANCj4gWWVw
LCBzL2luZm8vZGVidWcvIG1ha2VzIHNlbnNlLiBUaGUgZm9ybWF0IHNob3VsZCBoYXZlIGJlZW4g
IiUwOGx4IiBub3QNCj4gIiU4MGx4Iiwgbm90IHN1cmUgd2hlbiBJIHNjcmV3ZWQgdGhhdCB1cC4N
Cg0KVXNpbmcgIiUjeCIgaXMgYW4gYWx0ZXJuYXRpdmUgLSB1bmxlc3MgeW91IHJlYWxseSBuZWVk
IGZpeGVkIHdpZHRoLg0KDQpIb3dldmVyIGluIHRoaXMgY2FzZSAiJWxkIiBtaWdodCBiZSBtb3Jl
IGFwcHJvcHJpYXRlIQ0KSWYgdGhlIHZhbHVlIGlzIGEgLXZlIGVycm5vIG9uZSwgbWF5YmUgZXZl
biAiZXJybm8gJWQiIGFuZCBuZWdhdGUgdGhlIHZhbHVlLg0KDQoJRGF2aWQNCg0K
