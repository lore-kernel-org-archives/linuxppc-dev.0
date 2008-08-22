Return-Path: <temerkhanov@yandex.ru>
Received: from smtp11.yandex.ru (smtp11.yandex.ru [213.180.223.93])
	by ozlabs.org (Postfix) with ESMTP id 81386DF0E6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 02:13:42 +1000 (EST)
Received: from cifronik.21th.com ([62.16.86.116]:63970 "EHLO
	satanklaus.cifronic.local" smtp-auth: "temerkhanov" TLS-CIPHER: <none>
	TLS-PEER-CN1: <none>) by mail.yandex.ru with ESMTP id S1246717AbYHVQNd
	(ORCPT <rfc822;linuxppc-embedded@ozlabs.org>);
	Fri, 22 Aug 2008 20:13:33 +0400
From: Sergey Temerkhanov <temerkhanov@yandex.ru>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Linux Device Driver for Xilinx LL TEMAC 10/100/1000
	Ethernet NIC
Date: Fri, 22 Aug 2008 20:14:01 +0400
References: <48AA938C.4060309@dlasys.net>
In-Reply-To: <48AA938C.4060309@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808222014.01248.temerkhanov@yandex.ru>
Reply-To: temerkhanov@cifronik.ru
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

T24gVHVlc2RheSAxOSBBdWd1c3QgMjAwOCAxMzozNDowNCBEYXZpZCBILiBMeW5jaCBKci4gd3Jv
dGU6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN3aXRjaCAoaXAtPnByb3RvY29s
KSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhc2UgSVBQUk9UT19UQ1A6Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGFydCA9IHNp
emVvZihzdHJ1Y3QgaXBoZHIpICsgRVRIX0hMRU47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnNlcnQgPSBzaXplb2Yoc3RydWN0IGlwaGRyKSArIEVU
SF9ITEVOICsgMTY7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBsZW5ndGggPSBpcC0+dG90X2xlbiAtIHNpemVvZihzdHJ1Y3QgaXBoZHIpOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaGVhZGxlbiA9IEVUSF9I
TEVOCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgKyBzaXplb2Yoc3RydWN0IGlwaGRyKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCsgc2l6ZW9mKHN0cnVj
dCB0Y3BoZHIpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYnJlYWs7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhc2UgSVBQUk9UT19V
RFA6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGFy
dCA9IHNpemVvZihzdHJ1Y3QgaXBoZHIpICsgRVRIX0hMRU47Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbnNlcnQgPSBzaXplb2Yoc3RydWN0IGlwaGRy
KSArIEVUSF9ITEVOICsgNjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGxlbmd0aCA9IGlwLT50b3RfbGVuIC0gc2l6ZW9mKHN0cnVjdCBpcGhkcik7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBoZWFkbGVuID0g
RVRIX0hMRU4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqArIHNpemVvZihzdHJ1Y3QgaXBoZHIpCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKyBzaXplb2Yo
c3RydWN0IHVkcGhkcik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBicmVhazsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVmYXVsdDoK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9CgpXaHkgYWxsIHRoZXNlIGNhbGN1bGF0
aW9ucyBpbnN0ZWFkIG9mIHNrYl90cmFuc3BvcnRfb2Zmc2V0KHNrYikgYW5kIApza2ItPmNzdW1f
b2Zmc2V0IHVzYWdlPwoK
