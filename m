Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BB9C4332F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Nov 2022 04:06:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N7lW005TYz3f41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Nov 2022 15:06:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=realitydiluted.com (client-ip=63.228.164.32; helo=home.bethel-hill.org; envelope-from=sjhill@realitydiluted.com; receiver=<UNKNOWN>)
X-Greylist: delayed 2129 seconds by postgrey-1.36 at boromir; Fri, 11 Nov 2022 12:20:52 AEDT
Received: from home.bethel-hill.org (home.bethel-hill.org [63.228.164.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N7grN37v1z2yWl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2022 12:20:52 +1100 (AEDT)
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.89)
	(envelope-from <sjhill@realitydiluted.com>)
	id 1otIAY-0006qC-Sh
	for linuxppc-dev@lists.ozlabs.org; Fri, 11 Nov 2022 00:45:19 +0000
Message-ID: <8893e416-007c-f7b8-3b67-2ceec7db2e01@realitydiluted.com>
Date: Thu, 10 Nov 2022 18:45:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: linuxppc-dev@lists.ozlabs.org
From: "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: Writing not working to CPLD/FPGA.
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nSgsqDyB0LJNDhxoibAzvgj0"
X-Mailman-Approved-At: Fri, 11 Nov 2022 15:01:29 +1100
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nSgsqDyB0LJNDhxoibAzvgj0
Content-Type: multipart/mixed; boundary="------------J9DxCnMrg7Jc0DAot7OU4lbG";
 protected-headers="v1"
From: "Steven J. Hill" <sjhill@realitydiluted.com>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <8893e416-007c-f7b8-3b67-2ceec7db2e01@realitydiluted.com>
Subject: Writing not working to CPLD/FPGA.

--------------J9DxCnMrg7Jc0DAot7OU4lbG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8uDQoNCk15IHBsYXRmb3JtIGlzIGEgNzQ0N0Egd2l0aCBNYXJ2ZWxsIEdUNjQyNjAg
YnJpZGdlIGNoaXAuIEkgaGF2ZSBjdXJyZW50bHkNCmdvdCB0aGUga2VybmVsIHVwZ3JhZGVk
IHRvIHYzLjEyIChzdGFydGVkIGZyb20gdjIuNi4yNikgYW5kIG9ubHkgaGF2ZSBvbmUNCm1v
cmUgcGllY2UgdG8gZ2V0IHdvcmtpbmcgdGhhdCBoYXMgbmV2ZXIgd29ya2VkLiBUaGVyZSBp
cyBhIENQTEQgb24gdGhlDQpib2FyZC4gSXQgbWFwcyBpbiBqdXN0IGZpbmUgYW5kIEkgY2Fu
IHJlYWQgdGhlIHJlZ2lzdGVycyB3aXRob3V0IGlzc3VlLg0KSG93ZXZlciwgbm9uZSBvZiBt
eSB3cml0ZXMgd29yay4gSW4gdGhlIGJvb3Rsb2FkZXIsIEkgY2FuIHdyaXRlIHRoZSBDUExE
DQpyZWdpc3RlcnMgd2l0aG91dCBpc3N1ZS4gVGhlIHByZWJvb3QgY29kZSBpbiAnYXJjaC9w
b3dlcnBjL2Jvb3QnIGNhbiBhbHNvDQp3cml0ZSB0aGUgQ1BMRCByZWdpc3RlcnMuIFNvLCB3
cml0ZSBhY2Nlc3Mgc3RvcHMgd29ya2luZyBvbmNlIHRoZSBrZXJuZWwgaXMNCmJvb3RlZC4g
VXNpbmcgX1BBR0VfTk9fQ0FDSEUgd2l0aCBpb3JlbWFwX3Byb3QoKSBhbmQgb3RoZXIgZmxh
Z3MgZG9lcyBub3QNCndvcmsuIEhhcyBhbnlvbmUgZWxzZSBldmVyIGVuY291bnRlcmVkIHNv
bWV0aGluZyBzaW1pbGFyIGJlaGF2aW9yIGluIHRoZQ0KcGFzdD8gUGxlYXNlIENDOiBtZS4g
SSBhbSBub3Qgc3Vic2NyaWJlZCB0byB0aGUgbGlzdC4gVGhhbmtzIGluIGFkdmFuY2UuDQoN
Ci1TdGV2ZQ0K

--------------J9DxCnMrg7Jc0DAot7OU4lbG--

--------------nSgsqDyB0LJNDhxoibAzvgj0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQQ7FeQaKpedass6DAiDIrkfYhzfpwUCY22bHQUDAAAAAAAKCRCDIrkfYhzfp3l5
AKCMNucKwgWslrhzTuU9srXuFm+QngCgnU/h7rM39CXBBBtGxIH7DWv2/gM=
=iaqA
-----END PGP SIGNATURE-----

--------------nSgsqDyB0LJNDhxoibAzvgj0--
