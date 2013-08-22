Return-Path: <tony.luck@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by ozlabs.org (Postfix) with ESMTP id 840D62C00A2
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Aug 2013 09:17:26 +1000 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: Seiji Aguchi <seiji.aguchi@hds.com>, Aruna Balakrishnaiah
 <aruna@linux.vnet.ibm.com>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "keescook@chromium.org"
 <keescook@chromium.org>
Subject: RE: [RFC PATCH v2 04/11] pstore: Add compression support to pstore
Date: Thu, 22 Aug 2013 23:17:10 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31CC7AC0@ORSMSX106.amr.corp.intel.com>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
 <20130816131805.3338.68767.stgit@aruna-ThinkPad-T420>
 <A5ED84D3BB3A384992CBB9C77DEDA4D443E8F0D7@USINDEM103.corp.hds.com>
In-Reply-To: <A5ED84D3BB3A384992CBB9C77DEDA4D443E8F0D7@USINDEM103.corp.hds.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 "ccross@android.com" <ccross@android.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PDE+WyAgMzgzLjIwOTA1N10gUklQICBbPGZmZmZmZmZmODEzZDM5NDY+XSBzeXNycV9oYW5kbGVf
Y3Jhc2grMHgxNi8weDIwDQo8ND5bICAzODMuMjA5MDU3XSAgUlNQIDxmZmZmODgwMDZmNTUxZTgw
Pg0KPDQ+WyAgMzgzLjIwOTA1N10gQ1IyOiAwMDAwMDAwMDAwMDAwMDAwDQo8ND5bICAzODMuMjA5
MDU3XSAtLS1bIGVuZCB0cmFjZSAwNGExY2RkYWQzN2I0YjMzIF0tLS0NCjwzPlsgIDM4My4yMDkw
NTddIHBzdG9yZTogY29tcHJlc3Npb24gZmFpbGVkIGZvciBQYXJ0IDIgcmV0dXJuZWQgLTUNCjwz
PlsgIDM4My4yMDkwNTddIHBzdG9yZTogQ2FwdHVyZSB1bmNvbXByZXNzZWQgb29wcy9wYW5pYyBy
ZXBvcnQgb2YgUGFydCAyDQo8Mz5bICAzODMuMjA5MDU3XSBwc3RvcmU6IGNvbXByZXNzaW9uIGZh
aWxlZCBmb3IgUGFydCA1IHJldHVybmVkIC01DQoNCkludGVyZXN0aW5nLiAgV2l0aCBFUlNUIGJh
Y2tlbmQgSSBkaWRuJ3Qgc2VlIHRoZXNlIG1lc3NhZ2VzLiAgVHJhY2VzIGluIA0KcHN0b3JlIHJl
Y292ZXJlZCBmaWxlcyBnbyBhcyBmYXIgYXMgdGhlIGxpbmUgYmVmb3JlIHRoZSAiLS0tWyBlbmQg
dHJhY2UgMDRhMWNkZGFkMzdiNGIzMyBdLS0tIg0KDQpXaHkgdGhlIGRpZmZlcmVuY2UgZGVwZW5k
aW5nIG9uIHdoaWNoIGJhY2sgZW5kIGlzIGluIHVzZT8NCg0KQnV0IEkgYWdyZWUgdGhhdCB3ZSBz
aG91bGRuJ3QgaGF2ZSB0aGVzZSBtZXNzYWdlcy4gIFRoZXkgdXNlIHVwIHNwYWNlDQppbiB0aGUg
cGVyc2lzdGVudCBzdG9yZSB0aGF0IGNvdWxkIGJlIGJldHRlciB1c2VkIHNhdmluZyBzb21lIG1v
cmUgbGluZXMNCmZyb20gZWFybGllciBpbiB0aGUgY29uc29sZSBsb2cuDQoNCi1Ub255DQo=
