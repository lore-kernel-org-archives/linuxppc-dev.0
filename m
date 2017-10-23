Return-Path: <sbates@raithlin.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0101.outbound.protection.outlook.com [104.47.33.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLSPx2bzZzDqjm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 07:17:55 +1100 (AEDT)
From: "Stephen  Bates" <sbates@raithlin.com>
To: Balbir Singh <bsingharora@gmail.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Logan
 Gunthorpe" <logang@deltatee.com>
Subject: Re: lpar issue for ZONE_DEVICE p2pmem in 4.14-rc
Date: Mon, 23 Oct 2017 20:17:51 +0000
Message-ID: <C65BF19B-49B3-480E-9435-17949645B992@raithlin.com>
References: <2A16FB2A-71B2-41F1-993C-5A66DB2ADB1F@raithlin.com>
 <CAKTCnz=6ab=TCWFOknvAq2QxoXbTMhDfQMt5wOFzzUoYJRnUMA@mail.gmail.com>
 <AF0CC512-DC7D-45EB-B1AB-7132B48C38E1@raithlin.com>
 <20171023135338.58d0ab31@MiWiFi-R3-srv>
In-Reply-To: <20171023135338.58d0ab31@MiWiFi-R3-srv>
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

DQo+IFsgICAgMy41Mzc3ODBdIGxwYXI6IEF0dGVtcHRpbmcgdG8gcmVzaXplIEhQVCB0byBzaGlm
dCAyMQ0KPiBbICAgIDMuNTM5MjUxXSBVbmFibGUgdG8gcmVzaXplIGhhc2ggcGFnZSB0YWJsZSB0
byB0YXJnZXQgb3JkZXIgMjE6IC0xDQo+IFsgICAgMy41NDEwNzldIFVuYWJsZSB0byBjcmVhdGUg
bWFwcGluZyBmb3IgaG90IGFkZGVkIG1lbW9yeSAweGMwMDAyMTAwMDAwMDAwMDAuLjB4YzAwMDIx
MDAwNDAwMDAwMDogLTINCg0KPiBGb3IgIzEgYWJvdmUgcGxlYXNlIGNoZWNrIGlmIHlvdXIgcWVt
dSBzdXBwb3J0cyBIX1JFU0laRV9IUFRfKiBoY2FsbHM/IA0KDQpCYWxiaXIgZG8geW91IGhhdmUg
YW55IHN1Z2dlc3Rpb25zIGFzIHRvIGhvdyB0byB0ZXN0IGZvciB0aGlzIHN1cHBvcnQ/IE5vdGUg
SSBhbSBydW5uaW5nIHRoaXMgb24gbXkgeDg2XzY0IGhvc3Qgc28gdGhlcmUgaXMgbm8gdmlydHVh
bGl6YXRpb24gaGFyZHdhcmUgaW4gbXkgUUVNVS4gTXkgcWVtdSBpcyB2ZXJ5IHJlY2VudCAoUUVN
VSBlbXVsYXRvciB2ZXJzaW9uIDIuMTAuNTAgKHYyLjEwLjAtMTAyNi1nZDhmOTMyYy1kaXJ0eSkp
Lg0KDQo+IEZvciBjcmVhdGUgbWFwcGluZyBmYWlsdXJlcywgdGhlIHJjIGlzIC1FTk9FTlQuIENh
biB5b3UgaGVscCBkZWJ1ZyB0aGlzIGZ1cnRoZXI/IFdlIGNvdWxkIGRvIGhjYWxsIHRyYWNpbmcg
b3IgZW5hYmxlIGRlYnVnZ2luZy4NCg0KU3VyZSBJIGNhbiBoZWxwIGRlYnVnLiBNeSBvcmlnaW5h
bCBlbWFpbCBhbHNvIGhhZCBhbGwgeW91IG5lZWRlZCB0byByZWNyZWF0ZSB0aGlzIGlzc3VlIHNv
IHRoYXTigJlzIGFuIG9wdGlvbiB0b28/DQoNClN0ZXBoZW4NCg0KDQo=
