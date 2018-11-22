Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7AAC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 02:59:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3628A20684
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 02:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3628A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430kgn2VN8zDqSF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 13:59:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=63.217.80.70; helo=mxhk.zte.com.cn;
 envelope-from=wen.yang99@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
X-Greylist: delayed 973 seconds by postgrey-1.36 at bilbo;
 Thu, 22 Nov 2018 13:57:36 AEDT
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430kdD3tPmzDqQV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 13:57:36 +1100 (AEDT)
Received: from mse02.zte.com.cn (unknown [10.30.3.21])
 by Forcepoint Email with ESMTPS id F3EF5D7DDB5D09C3DCA0;
 Thu, 22 Nov 2018 10:41:18 +0800 (CST)
Received: from kjyxapp05.zte.com.cn ([10.30.12.204])
 by mse02.zte.com.cn with SMTP id wAM2efm6024458;
 Thu, 22 Nov 2018 10:41:09 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from mapi (kjyxapp04[null]) by mapi (Zmail) with MAPI id mid14;
 Thu, 22 Nov 2018 10:41:12 +0800 (CST)
Date: Thu, 22 Nov 2018 10:41:12 +0800 (CST)
X-Zmail-TransId: 2b065bf61748c7ef8799
X-Mailer: Zmail v1.0
Message-ID: <201811221041128621504@zte.com.cn>
In-Reply-To: <d69e7c77-e9fa-470a-db9f-ff9cd0476334@c-s.fr>
References: 1542786111-18648-1-git-send-email-wen.yang99@zte.com.cn,
 d69e7c77-e9fa-470a-db9f-ff9cd0476334@c-s.fr
Mime-Version: 1.0
From: <wen.yang99@zte.com.cn>
To: <christophe.leroy@c-s.fr>, <qiang.zhao@nxp.com>
Subject: =?UTF-8?B?562U5aSNOiBSZTogW1BBVENIIDIvNF0gc29jL2ZzbC9xZTogZml4IHBvdGVudGlhbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW51Y2Nfb2ZfcGFyc2VfdGRt?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse02.zte.com.cn wAM2efm6024458
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: wang.yi59@zte.com.cn, zhong.weidong@zte.com.cn,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, julia.lawall@lip6.fr,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 qiang.zhao@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



--=====_001_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgQ2hyaXN0b3BoZSwgdGhhbmsgeW91IGZvciB5b3VyIHJldmlldy4KVGhlcmUgYXJlIHR3byBw
cm9ibGVtcyBpbiB0aGUgdWNjX29mX3BhcnNlX3RkbSBmdW5jdGlvbi4KMSwgTlVMTCBwb2ludGVy
IHJlZmVyZW5jZQoyLCBwZGV2IGdldHMgbW9kaWZpZWQsIGlvbWFwIHdhcyBkb25lIHdpdGggYSBk
aWZmZXJlbnQgcGRldi4KCldlIHdpbGwgc3VibWl0IGEgcGF0Y2ggdG8gcmVwYWlyIGl0IGxhdGVy
LgpUaGFua3MuCgoxMzIgICAgICAgICBwZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShucDIp
OwouLi4uLi4KMTQxICAgICAgICAgdXRkbS0+c2lfcmVncyA9IGRldm1faW9yZW1hcF9yZXNvdXJj
ZSgmcGRldi0+ZGV2LCByZXMpOyAgIC0tLT4gdXNlIHBkZXYgdG8gY2FsbCAgZGV2bV9pb3JlbWFw
IAouLi4uLi4KMTUzICAgICAgICAgcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUobnAyKTsg
ICAtLS0+VGhpcyBsaW5lLCBwZGV2IGdldHMgbW9kaWZpZWQgIAoxNTQgICAgICAgICBpZiAoIXBk
ZXYpIHsKMTU1ICAgICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOwoxNTYgICAgICAgICAgICAg
ICAgIHByX2VycigiJXBPRm46IGZhaWxlZCB0byBsb29rdXAgcGRldlxuIiwgbnAyKTsKMTU3ICAg
ICAgICAgICAgICAgICBvZl9ub2RlX3B1dChucDIpOwoxNTggICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX21pc3Nfc2lyYW1fcHJvcGVydHk7ICAgICAgICAgICAgICAgICAgICAgICAgIC0tLS0tLT4g
VGhpcyBsaW5lLCBpZiBwZGV2IGlzIE5VTEwsIHdpbGwganVtcCB0byBsYWJlbCBlcnJfbWlzc19z
aXJhbV9wcm9wZXJ0eQoxNTkgICAgICAgICB9Ci4uLi4uLgoxNjMgICAgICAgICB1dGRtLT5zaXJh
bSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2LCByZXMpOyAgLS0+IHVzZSAgY2hh
bmdlZCBwZGV2IHRvIGNhbGwgZGV2bV9pb3JlbWFwIAouLi4uLi4KMTc1IAoxNzYgZXJyX21pc3Nf
c2lyYW1fcHJvcGVydHk6CjE3NyAgICAgICAgIGRldm1faW91bm1hcCgmcGRldi0+ZGV2LCB1dGRt
LT5zaV9yZWdzKTsgICAgLS0tLS0tPiBXaXRoaW4gdGhlIGNvZGUgYmxvY2ssICBpZiBwZGV2IGlz
IE5VTEwsICBrZXJuZWwgcGFuaWMgd2lsbCBiZSB0cmlnZ2VyZWQ7IGRldm1faW91bm1hcCgpIHdp
bGwgYWxzZSBmYWlsIGV2ZW4gd2hlbiB0aGUgbmV3IHBkZXYgaXMgdmFsaWQuCjE3OCAgICAgICAg
IHJldHVybiByZXQ7CjE3OSB9CgoKLS0tLS0tLS0tLS0tLS0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0t
LS0tLS0tLS0tLS0tCuWPkeS7tuS6uu+8mkNocmlzdG9waGVMRVJPWSA8Y2hyaXN0b3BoZS5sZXJv
eUBjLXMuZnI+CuaUtuS7tuS6uu+8muaWh+a0izEwMTU2MzE0O3FpYW5nLnpoYW9AbnhwLmNvbSA8
cWlhbmcuemhhb0BueHAuY29tPgrmioTpgIHkurrvvJrmsarnv7wxMDEyOTk2Mzvpkp/ljavkuJwx
MDAwMTA4ODtsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPmxlb3lhbmcubGlAbnhwLmNvbSA8bGVveWFuZy5saUBueHAuY29tPkp1bGlhIExh
d2FsbCA8anVsaWEubGF3YWxsQGxpcDYuZnI+bGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcg
PGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZyA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPgrml6Ug5pyf
IO+8mjIwMTjlubQxMeaciDIx5pelIDE4OjQ2CuS4uyDpopgg77yaUmU6IFtQQVRDSCAyLzRdIHNv
Yy9mc2wvcWU6IGZpeCBwb3RlbnRpYWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGludWNjX29m
X3BhcnNlX3RkbQoKCkxlIDIxLzExLzIwMTggw6AgMDg6NDEsIFdlbiBZYW5nIGEgw6ljcml0IDoK
PiBUaGlzIHBhdGNoIGZpeGVzIGEgcG9zc2libGUgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlIGlu
Cj4gdWNjX29mX3BhcnNlX3RkbSwgZGV0ZWN0ZWQgYnkgdGhlIHNlbWFudGljIHBhdGNoCj4gZGVy
ZWZfbnVsbC5jb2NjaSwgd2l0aCB0aGUgZm9sbG93aW5nIHdhcm5pbmc6Cj4KPiAuL2RyaXZlcnMv
c29jL2ZzbC9xZS9xZV90ZG0uYzoxNzc6MjEtMjQ6IEVSUk9SOiBwZGV2IGlzIE5VTEwgYnV0IGRl
cmVmZXJlbmNlZC4KPgo+IFRoZSBmb2xsb3dpbmcgY29kZSBoYXMgcG90ZW50aWFsIG51bGwgcG9p
bnRlciByZWZlcmVuY2VzOgo+ICAgICAgICAgIHBkZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2Rl
KG5wMik7Cj4gICAgICAgICAgaWYgKCFwZGV2KSB7Cj4gICAgICAgICAgICAgICAgICByZXQgPSAt
RUlOVkFMOwo+ICAgICAgICAgICAgICAgICAgcHJfZXJyKCIlcE9GbjogZmFpbGVkIHRvIGxvb2t1
cCBwZGV2XG4iLCBucDIpOwo+ICAgICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQobnAyKTsKPiAg
ICAgICAgICAgICAgICAgIGdvdG8gZXJyX21pc3Nfc2lyYW1fcHJvcGVydHk7Cj4gICAgICAgICAg
fQo+IC4uLgo+IGVycl9taXNzX3NpcmFtX3Byb3BlcnR5Ogo+ICAgICAgICAgIGRldm1faW91bm1h
cCgmcGRldi0+ZGV2LCB1dGRtLT5zaV9yZWdzKTsKPgo+IFNpZ25lZC1vZmYtYnk6IFdlbiBZYW5n
IDx3ZW4ueWFuZzk5QHp0ZS5jb20uY24+Cj4gUmV2aWV3ZWQtYnk6IFRhbiBIdSA8dGFuLmh1QHp0
ZS5jb20uY24+Cj4gQ0M6IEp1bGlhIExhd2FsbCA8anVsaWEubGF3YWxsQGxpcDYuZnI+Cj4gLS0t
Cj4gICBkcml2ZXJzL3NvYy9mc2wvcWUvcWVfdGRtLmMgfCAzICsrLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc29jL2ZzbC9xZS9xZV90ZG0uYyBiL2RyaXZlcnMvc29jL2ZzbC9xZS9xZV90ZG0uYwo+IGlu
ZGV4IGY3OGMzNDYuLjE2NjM3OGIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9zb2MvZnNsL3FlL3Fl
X3RkbS5jCj4gKysrIGIvZHJpdmVycy9zb2MvZnNsL3FlL3FlX3RkbS5jCj4gQEAgLTE3NCw3ICsx
NzQsOCBAQCBpbnQgdWNjX29mX3BhcnNlX3RkbShzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLCBzdHJ1
Y3QgdWNjX3RkbSAqdXRkbSwKPiAgICAgICByZXR1cm4gcmV0Owo+Cj4gICBlcnJfbWlzc19zaXJh
bV9wcm9wZXJ0eToKPiAtICAgIGRldm1faW91bm1hcCgmcGRldi0+ZGV2LCB1dGRtLT5zaV9yZWdz
KTsKPiArICAgIGlmIChwZGV2KQo+ICsgICAgICAgIGRldm1faW91bm1hcCgmcGRldi0+ZGV2LCB1
dGRtLT5zaV9yZWdzKTsKCllvdSBhcmUganVzdCBoaWRpbmcgdGhlIGlzc3VlLCBub3QgZml4aW5n
IGl0LgoKVGhlIHByb2JsZW0gaXMgdGhhdCBwZGV2IGdldHMgbW9kaWZpZWQsIHNvIGluIGFueSBj
YXNlIHRoYXQKZGV2bV9pb3VubWFwKCkgd2lsbCBmYWlsIGV2ZW4gd2hlbiB0aGUgbmV3IHBkZXYg
aXMgdmFsaWQsIGJlY2F1c2UgdGhlCmlvbWFwIHdhcyBkb25lIHdpdGggYSBkaWZmZXJlbnQgcGRl
di4KCkNocmlzdG9waGUKCgoKPiAgICAgICByZXR1cm4gcmV0Owo+ICAgfQo+ICAgRVhQT1JUX1NZ
TUJPTCh1Y2Nfb2ZfcGFyc2VfdGRtKTsKPg==


--=====_003_next=====--

--=====_001_next=====--

