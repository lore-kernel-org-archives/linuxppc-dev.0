Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 69DD5140098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 18:48:01 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 15865-07 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 10 Apr 2014 09:47:51 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: "'hongbo.zhang@freescale.com'" <hongbo.zhang@freescale.com>,
 "vkoul@infradead.org" <vkoul@infradead.org>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, "dmaengine@vger.kernel.org"
 <dmaengine@vger.kernel.org>
Subject: RE: [PATCH v3 2/8] DMA: Freescale: unify register access methods
Date: Thu, 10 Apr 2014 08:46:14 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6F4317@AcuExch.aculab.com>
References: <1397113805-24171-1-git-send-email-hongbo.zhang@freescale.com>
 <1397113805-24171-3-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1397113805-24171-3-git-send-email-hongbo.zhang@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "scottwood@freescale.com" <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "leo.li@freescale.com" <leo.li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogaG9uZ2JvLnpoYW5nQGZyZWVzY2FsZS5jb20NCj4gTWV0aG9kcyBvZiBhY2Nlc3Npbmcg
RE1BIGNvbnRvcmxsZXIgcmVnaXN0ZXJzIGFyZSBpbmNvbnNpc3RlbnQsIHNvbWUgcmVnaXN0ZXJz
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl4NCj4gYXJlIGFjY2Vzc2VkIGJ5IERN
QV9JTi9PVVQgZGlyZWN0bHksIHdoaWxlIG90aGVycyBhcmUgYWNjZXNzZWQgYnkgZnVuY3Rpb25z
DQo+IGdldC9zZXRfKiB3aGljaCBhcmUgd3JhcHBlcnMgb2YgRE1BX0lOL09VVCwgYW5kIGV2ZW4g
Zm9yIHRoZSBCQ1IgcmVnaXN0ZXIsIGl0DQo+IGlzIHJlYWQgYnkgZ2V0X2JjciBidXQgd3JpdHRl
biBieSBETUFfT1VULg0KPiBUaGlzIHBhdGNoIHVuaWZpZXMgdGhlIGluY29uc2lzdGVudCBtZXRo
b2RzLCBhbGwgcmVnaXN0ZXJzIGFyZSBhY2Nlc3NlZCBieQ0KPiBnZXQvc2V0Xyogbm93Lg0KDQoJ
RGF2aWQNCg0K
