Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id D3FCD1A0947
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 21:39:48 +1100 (AEDT)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 12288-04 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 20 Nov 2014 10:39:42 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mel Gorman' <mgorman@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 03/10] mm: Convert p[te|md]_numa users to
 p[te|md]_protnone_numa
Date: Thu, 20 Nov 2014 10:38:56 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1C9F48CB@AcuExch.aculab.com>
References: <1416478790-27522-1-git-send-email-mgorman@suse.de>
 <1416478790-27522-4-git-send-email-mgorman@suse.de>
In-Reply-To: <1416478790-27522-4-git-send-email-mgorman@suse.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Rik van Riel <riel@redhat.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, Hugh Dickins <hughd@google.com>,
 Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>, Dave Jones <davej@redhat.com>,
 Sasha
 Levin <sasha.levin@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogIE1lbCBHb3JtYW4NCj4gQ29udmVydCBleGlzdGluZyB1c2VycyBvZiBwdGVfbnVtYSBh
bmQgZnJpZW5kcyB0byB0aGUgbmV3IGhlbHBlci4gTm90ZQ0KPiB0aGF0IHRoZSBrZXJuZWwgaXMg
YnJva2VuIGFmdGVyIHRoaXMgcGF0Y2ggaXMgYXBwbGllZCB1bnRpbCB0aGUgb3RoZXINCj4gcGFn
ZSB0YWJsZSBtb2RpZmllcnMgYXJlIGFsc28gYWx0ZXJlZC4gVGhpcyBwYXRjaCBsYXlvdXQgaXMg
dG8gbWFrZQ0KPiByZXZpZXcgZWFzaWVyLg0KDQpEb2Vzbid0IHRoYXQgYnJlYWsgYmlzZWN0aW9u
Pw0KDQoJRGF2aWQNCg0K
