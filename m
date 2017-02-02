Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDkBf1GH0zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 02:17:29 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: =?utf-8?B?J01pY2hhbCBTdWNow6FuZWsn?= <msuchanek@suse.de>, Vicky
 <honclo@linux.vnet.ibm.com>
CC: Nayna Jain <nayna@linux.vnet.ibm.com>, Marcel Selhorst
 <tpmdd@selhorst.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Jarkko Sakkinen
 <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>, "tpmdd-devel@lists.sourceforge.net"
 <tpmdd-devel@lists.sourceforge.net>, Paul Mackerras <paulus@samba.org>,
 Ashley Lai <ashleydlai@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: ibmvtpm byteswapping inconsistency
Date: Thu, 2 Feb 2017 15:17:19 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0278B33@AcuExch.aculab.com>
References: <20170126212248.3f3e9103@kitsune.suse.cz>
 <20170126220536.GB31937@obsidianresearch.com>
 <024dadba-a75c-ab59-9d12-a9bea81f9bda@gmail.com>
 <F14AC3E9-E04F-4EF0-9C7E-999D481EA577@linux.vnet.ibm.com>
 <20170202122942.7fd9988d@kitsune.suse.cz>
In-Reply-To: <20170202122942.7fd9988d@kitsune.suse.cz>
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

RnJvbTogTWljaGFsIFN1Y2jDoW5law0KPiBTZW50OiAwMiBGZWJydWFyeSAyMDE3IDExOjMwDQou
Li4NCj4gVGhlIHdvcmQgaXMgbWFya2VkIGNvcnJlY3RseSBhcyBfX2JlNjQgaW4gdGhhdCBwYXRj
aCBiZWNhdXNlIGNvdW50IGFuZA0KPiBoYW5kbGUgYXJlIHN3YXBwZWQgdG8gQkUgd2hlbiBzYXZl
ZCB0byBpdCBhbmQgdGhlIHdob2xlIHdvcmQgaXMgdGhlbg0KPiBzd2FwcGVkIGFnYWluIHdoZW4g
bG9hZGVkLiBJZiB5b3UganVzdCBsb2FkICgodTY0KUlCTVZUUE1fVkFMSURfQ01EIDw8DQo+IDU2
IHwgKCh1NjQpVlRQTV9UUE1fQ09NTUFORCA8PCA0OCkgfCAoKHU2NCljb3VudCA8PCAzMikgfA0K
PiBpYm12dHBtLT5ydGNlX2RtYV9oYW5kbGUgaW4gYSByZWdpc3RlciBpdCB3b3JrcyBlcXVhbGx5
IHdlbGwNCj4gd2l0aG91dCBhbnkgX19iZSBhbmQgc3dhcHMgaW52b2x2ZWQuDQoNCkFuZCB0aGF0
IHZlcnNpb24gd2lsbCBhbG1vc3QgY2VydGFpbmx5IGdlbmVyYXRlIG11Y2ggYmV0dGVyIGNvZGUu
DQoNCglEYXZpZA0KDQo=
