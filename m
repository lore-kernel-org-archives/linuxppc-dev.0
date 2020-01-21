Return-Path: <SRS0=KLET=3K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEFFC33CAA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 05:56:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 161F422314
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 05:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161F422314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 481yTt0yFBzDqcc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 16:56:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=vivo.com (client-ip=59.111.176.148;
 helo=m176148.mail.qiye.163.com; envelope-from=wenhu.wang@vivo.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=vivo.com
X-Greylist: delayed 512 seconds by postgrey-1.36 at bilbo;
 Tue, 21 Jan 2020 16:29:02 AEDT
Received: from m176148.mail.qiye.163.com (m176148.mail.qiye.163.com
 [59.111.176.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 481xsp0bzwzDqV4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2020 16:29:01 +1100 (AEDT)
Received: from vivo.com (wm-8.qy.internal [127.0.0.1])
 by m176148.mail.qiye.163.com (Hmail) with ESMTP id A650F1A37B5;
 Tue, 21 Jan 2020 13:20:19 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AFAA8AA0CH7o6kMJF-XfXKq9.3.1579584019640.Hmail.wenhu.wang@vivo.com>
To: Scott Wood <oss@buserror.net>
Subject: =?UTF-8?B?UmU6W1BBVENIXSBwb3dlcnBjL0tjb25maWc6IE1ha2UgRlNMXzg1WFhfQ0FDSEVfU1JBTSBjb25maWd1cmFibGU=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.227
In-Reply-To: <bd0fa23b900fe967a8c3c11abd1ba9a47cec474f.camel@buserror.net>
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.227) ] by ajax-webmail (
 [127.0.0.1] ) ; Tue, 21 Jan 2020 13:20:19 +0800 (GMT+08:00)
From: =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date: Tue, 21 Jan 2020 13:20:19 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVCSktCQkJMTE9CSElDTVlXWShZQU
 hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhNSktMQkpPSEhPN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
 WUc6PTo6Qzo6SzgzTBRNEDYxPVYjHSMwCkJVSFVKTkxCTkNPS0lKQkJDVTMWGhIXVQweFRMOVQwa
 FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJTkpVTE9VSUlMWVdZCAFZQU9MQ0I3Bg++
X-HM-Tid: 0a6fc68b5ce59394kuwsa650f1a37b5
X-Mailman-Approved-At: Tue, 21 Jan 2020 16:55:13 +1100
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
Cc: Rai Harninder <harninder.rai@nxp.com>, trivial@kernel.org,
 linux-kernel@vger.kernel.org, wangwenhu <wenhu.pku@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

RnJvbTogU2NvdHQgV29vZCA8b3NzQGJ1c2Vycm9yLm5ldD4KRGF0ZTogMjAyMC0wMS0yMSAxMToy
NToyNQpUbzogIHdhbmd3ZW5odSA8d2VuaHUucGt1QGdtYWlsLmNvbT4sS3VtYXIgR2FsYSA8Z2Fs
YWtAa2VybmVsLmNyYXNoaW5nLm9yZz4sQmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVuaEBrZXJu
ZWwuY3Jhc2hpbmcub3JnPixQYXVsIE1hY2tlcnJhcyA8cGF1bHVzQHNhbWJhLm9yZz4sTWljaGFl
bCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1PixsaW51eHBwYy1kZXZAbGlzdHMub3psYWJz
Lm9yZyxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCkNjOiAgdHJpdmlhbEBrZXJuZWwub3Jn
LHdlbmh1LndhbmdAdml2by5jb20sUmFpIEhhcm5pbmRlciA8aGFybmluZGVyLnJhaUBueHAuY29t
PgpTdWJqZWN0OiBSZTogW1BBVENIXSBwb3dlcnBjL0tjb25maWc6IE1ha2UgRlNMXzg1WFhfQ0FD
SEVfU1JBTSBjb25maWd1cmFibGU+T24gTW9uLCAyMDIwLTAxLTIwIGF0IDA2OjQzIC0wODAwLCB3
YW5nd2VuaHUgd3JvdGU6Cj4+IEZyb206IHdhbmd3ZW5odSA8d2VuaHUud2FuZ0B2aXZvLmNvbT4K
Pj4gCj4+IFdoZW4gZ2VuZXJhdGluZyAuY29uZmlnIGZpbGUgd2l0aCBtZW51Y29uZmlnIG9uIEZy
ZWVzY2FsZSBCT09LRQo+PiBTT0MsIEZTTF84NVhYX0NBQ0hFX1NSQU0gaXMgbm90IGNvbmZpZ3Vy
YWJsZSBmb3IgdGhlIGxhY2sgb2YKPj4gZGVzY3JpcHRpb24gaW4gdGhlIEtjb25maWcgZmllbGQs
IHdoaWNoIG1ha2VzIGl0IGltcG9zc2libGUKPj4gdG8gc3VwcG9ydCBMMkNhY2hlLVNyYW0gZHJp
dmVyLiBBZGQgYSBkZXNjcmlwdGlvbiB0byBtYWtlIGl0Cj4+IGNvbmZpZ3VyYWJsZS4KPj4gCj4+
IFNpZ25lZC1vZmYtYnk6IHdhbmd3ZW5odSA8d2VuaHUud2FuZ0B2aXZvLmNvbT4KPgo+VGhlIGlu
dGVudCB3YXMgdGhhdCBkcml2ZXJzIHVzaW5nIHRoZSBTUkFNIEFQSSB3b3VsZCBzZWxlY3QgdGhl
IHN5bWJvbC4gIFdoYXQKPmlzIHRoZSB1c2UgY2FzZSBmb3Igc2VsZWN0aW5nIGl0IG1hbnVhbGx5
Pwo+CgpXaXRoIGEgcmVwb3NpdG9yeSBvZiBtdWx0aXBsZSBwcm9kdWN0cyhtZWFuaW5nIGRpZmZl
cmVudCBkZWZjb25maWdzKSBhbmQgbXVsdGlwbGUKZGV2ZWxvcGVycywgdGhlIEtjb25maWdzIG9m
IHRoZSBLZXJuZWwgU291cmNlIFRyZWUgY2hhbmdlIGZyZXF1ZW50bHkuIFNvIHRoZSAibWFrZSBt
ZW51Y29uZmlnIgpwcm9jZXNzIGlzIG5lZWRlZCBmb3IgZGVmY29uZmlncycgcmUtZ2VuZXJhdGlu
ZyBvciB1cGRhdGluZyBmb3IgdGhlIGNvbXBsZXhpdHkgb2YgZGVwZW5kZW5jaWVzCmJldHdlZW4g
ZGlmZmVyZW50IGZlYXR1cmVzIGRlZmluZWQgaW4gdGhlIEtjb25maWdzLgoKPlNpbmNlIHRoaXMg
Y29kZSB3YXMgYWRkZWQgYWxtb3N0IHRlbiB5ZWFycyBhZ28gYW5kIHRoZXJlIGFyZSBzdGlsbCBu
byAoaW4tCj50cmVlPykgdXNlcnMgb2YgdGhlIEFQSSwgd2Ugc2hvdWxkIGp1c3QgcmVtb3ZlIHRo
ZSBzcmFtIGNvZGUgKHVubGVzcyB0aGlzCj5wcm9kcyBzb21lb25lIHRvIHN1Ym1pdCBzdWNoIGEg
dXNlciB2ZXJ5IHNvb24pLgo+CgpZZXMsIHByZXR0eSBsb25nIGEgdGltZS4gQnV0IHdlIERPIHJl
YWxseSB1c2UgdGhlIEFQSSBub3cgZm9yIFBQQ0U1MDAvRnJlZXNjYWxlIFNvQy4KTGlrZSBzb21l
dGltZXMgd2UgbmVlZCB0byByZXNldCB0aGUgd2hvbGUgUkFNLCB0aGVuIHRoZSBMMi1DYWNoZSB3
b3VsZCBiZSB1c2VkIGFzClNSQU0gZm9yIGJhY2t1cCB1c2luZy4gU2luY2UgaXQgaXMgdXNlZnVs
IGZvciB1cyBub3csIGEgcmUtY29uc2lkZXJhdGlvbiBpcyByZWNvbW1hbmRlZC4KCj4tU2NvdHQK
Pgo+CgotLQpXZW5odQp2aXZvDQoNCg==
