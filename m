Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [88.79.252.171])
	by ozlabs.org (Postfix) with ESMTP id BDE59B6EF3
	for <linuxppc-dev@ozlabs.org>; Fri, 13 May 2011 18:36:40 +1000 (EST)
From: <Sergej.Stepanov@ids.de>
To: <mlcreech@gmail.com>
Date: Fri, 13 May 2011 10:34:21 +0200
Subject: Re: fsl_udc_core: BUG: scheduling while atomic
Message-ID: <4206182445660643B9AEB8D4E55BBD0A1533BC2781@HERMES2>
References: <BANLkTikp5yVgrCe7tbc4cvG5wvy7XJp2fQ@mail.gmail.com>
	<4206182445660643B9AEB8D4E55BBD0A1533BC2780@HERMES2>
	<BANLkTim8ntQHkcm_yOgD+UQQb+b+tSoFqA@mail.gmail.com>
In-Reply-To: <BANLkTim8ntQHkcm_yOgD+UQQb+b+tSoFqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SSB3b3VsZCBzYXkgaXQgaXMgYSBnZW5lcmFsIHByb2JsZW0gYnkgdXNpbmcgQ09ORklHX1BSRUVN
UFRfVk9MVU5UQVJZLApub3Qgb25seSBGcmVlc2NhbGUuLi4KCkFtIERvbm5lcnN0YWcsIGRlbiAx
Mi4wNS4yMDExLCAxMTozMCAtMDQwMCBzY2hyaWViIE1hdHRoZXcgTC4gQ3JlZWNoOgo+IE9uIFRo
dSwgTWF5IDEyLCAyMDExIGF0IDQ6MzcgQU0sICA8U2VyZ2VqLlN0ZXBhbm92QGlkcy5kZT4gd3Jv
dGU6Cj4gPiBIaSBNYXR0aGVldywKPiA+Cj4gPiBzdWNoIG9vcHMgeW91IGNhbiBnZXQgYWxzbyB3
aXRoIHNwaS4KPiA+IEZvciBzdWNoIHByb2JsZW0gaGVscHMgdG8gY29tcGlsZSB5b3VyIGtlcm5l
bCB3aXRoIG90aGVyIHByZWVtcHRpb24KPiA+IG1vZGVsOgo+ID4gIC0gcHJlZW1wdAo+ID4gIC0g
c3RhbmRhcmQKPiA+ICAtICEhISBidXQgbm90IHZvbHVudGFyeSBwcmVlbXB0aW9uICEhIQo+IAo+
IFRoYW5rcyBTZXJnZWosIGluZGVlZCBJJ20gY3VycmVudGx5IHVzaW5nIENPTkZJR19QUkVFTVBU
X1ZPTFVOVEFSWSBvbgo+IHRoaXMgYm9hcmQuICBJJ2xsIGNoYW5nZSBpdCB0byBmaXggdGhpcyBw
cm9ibGVtIGZvciBub3cuCj4gCj4gRG8geW91IGhhcHBlbiB0byBrbm93IHdoZXRoZXIgdGhlIEZy
ZWVzY2FsZSBmb2xrcyBpbnRlbmQgdG8gZml4IHRoaXM/Cj4gSWYgbm90LCBpdCBzZWVtcyBsaWtl
IGF0IGxlYXN0IHNvbWUgc29ydCBvZiB3YXJuaW5nIGlzIGluIG9yZGVyLgo+IAo+IC0tIAo+IE1h
dHRoZXcgTC4gQ3JlZWNoCg==
