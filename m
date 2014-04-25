Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 504C7140082
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Apr 2014 19:44:26 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 06034-10 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 25 Apr 2014 10:44:21 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yijing Wang' <wangyijing@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH 00/13] Refactor pci_is_brdige() to simplify code
Date: Fri, 25 Apr 2014 09:42:45 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6FEEB0@AcuExch.aculab.com>
References: <1398417515-8740-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1398417515-8740-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogWWlqaW5nIFdhbmcNCj4gVGhpcyBwYXRjaHNldCByZW5hbWUgdGhlIGN1cnJlbnQgcGNp
X2lzX2JyaWRnZSgpIHRvIHBjaV9oYXNfc3Vib3JkaW5hdGUoKSwNCj4gYW5kIGludHJvZHVjZSBh
IG5ldyBwY2lfaXNfYnJpZGdlKCkgd2hpY2ggZGV0ZXJtaW5lIHBjaSBicmlkZ2UgYnkgY2hlY2sN
Cj4gZGV2LT5oZHJfdHlwZS4gVGhlIG5ldyBvbmUgaXMgbW9yZSBhY2N1cmF0ZS4gUENJZSBTcGVj
IGRlZmluZSB0aGUgcGNpDQo+IGRldmljZSBpcyBhIGJyaWRnZSBieSB0aGUgZGV2LT5oZHJfdHlw
ZSA9IDB4MDEgfHwgMHgwMi4NCg0KVGhhdCBpcyBhIGRhbmdlcm91cyByZW5hbWUgYW5kIGlzIGxp
a2VseSB0byBjYXVzZSBkaWZmaWN1bHQgdG8NCmlkZW50aWZ5IGJ1Z3MgaW4gYW55IGNvZGUgeW91
J3ZlIG1pc3NlZC4NCg0KCURhdmlkDQoNCg==
