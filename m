Return-Path: <r58472@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 75578B70B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 14:11:52 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Chen Peter-B29397 <B29397@freescale.com>, "balbi@ti.com" <balbi@ti.com>,
 "mina86@mina86.com" <mina86@mina86.com>
Subject: RE: [PATCH v2] USB: fsl_udc_core: use usb_endpoint_xfer_isoc to
 judge ISO XFER
Date: Tue, 22 Nov 2011 03:11:43 +0000
Message-ID: <3F607A5180246847A760FD34122A1E052D8196@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1321926945-8182-1-git-send-email-peter.chen@freescale.com>
In-Reply-To: <1321926945-8182-1-git-send-email-peter.chen@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "gregkh@suse.de" <gregkh@suse.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "hzpeterchen@gmail.com" <hzpeterchen@gmail.com>,
 "stable@kernel.org" <stable@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiBTdWJqZWN0OiBbUEFUQ0ggdjJdIFVTQjogZnNsX3VkY19jb3JlOiB1c2UgdXNiX2VuZHBvaW50
X3hmZXJfaXNvYyB0byBqdWRnZSBJU08NCj4gWEZFUg0KPiANCj4gU29tZSBJU08gZ2FkZ2V0cywg
bGlrZSBhdWRpbywgaGFzIFNZTkMgYXR0cmlidXRlIGFzIHdlbGwgYXMNCj4gVVNCX0VORFBPSU5U
X1hGRVJfSVNPQyBmb3IgdGhlaXIgYm1BdHRyaWJ1dGVzIGF0IElTTyBlbmRwb2ludCBkZXNjcmlw
dG9yLiBTbywgaXQNCj4gbmVlZHMgdG8gdXNlIHVzYl9lbmRwb2ludF94ZmVyX2lzb2MgdG8ganVk
Z2UgSVNPIFhGRVIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBDaGVuIDxwZXRlci5jaGVu
QGZyZWVzY2FsZS5jb20+DQoNCkFja2VkLWJ5OiBMaSBZYW5nIDxsZW9saUBmcmVlc2NhbGUuY29t
Pg0KDQotIExlbw0K
