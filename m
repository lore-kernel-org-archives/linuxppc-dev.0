Date: Mon, 14 Feb 2000 10:26:38 -0600 (CST)
From: Nathan Ingersoll <ningerso@d.umn.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Bug in acceled Xpmac?
Message-ID: <Pine.SO4.4.02.10002140848100.5900-200000@bulldog5.d.umn.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1986831816-950545598=:5900"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1986831816-950545598=:5900
Content-Type: TEXT/PLAIN; charset=US-ASCII

It looks like the accelerated Xpmac that was released in January may have
a bug in mouse handling.

I was working on a small epplet for one button mouse users to make better
use of enlightenment. When using the version of Xpmac that shipped with
LinuxPPC 1999 Q1 it worked fine. But when using the recent accelerated
version, the mouse functionality wouldn't change.

XGetPointerMapping returns the values that were set, but it doesn't seem
to be updating the way it handles the button.

Has anyone else seen similar behavior or know of a fix? I attached the
source of my program for anyone interested in trying it out.

---------------------------------------------------------------------------
|   Nathan Ingersoll             |   Computer Science/Mathematics         |
|   mailto: ningerso@d.umn.edu   |   University of Minnesota-Duluth       |
|   http://umn.edu/~ningerso     |   http://www.d.umn.edu                 |
---------------------------------------------------------------------------

---559023410-1986831816-950545598=:5900
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="E-UniButton.c"
Content-ID: <Pine.SO4.4.02.10002141026380.5900@bulldog5.d.umn.edu>
Content-Description: E-UniButton.c
Content-Disposition: attachment; filename="E-UniButton.c"
Content-Transfer-Encoding: BASE64

LyoNCiAqIENvcHlyaWdodCAoQykgMjAwMC0yMDAxLCBOYXRoYW4gSW5nZXJz
b2xsDQogKg0KICogVGhpcyBzb2Z0d2FyZSBpcyBsaWNlbnNlZCB1bmRlciB0
aGUgR05VIEdlbmVyYWwgUHVibGljDQogKiBMaWNlbnNlLiBJZiB5b3UgZGlk
IG5vdCByZWNlaXZlIGEgY29weSB3aXRoIHRoaXMgc29mdHdhcmUsDQogKiBp
dCBtYXkgYmUgb2J0YWluZWQgZnJvbSBodHRwOi8vd3d3LmdudS5vcmcvDQog
Ki8NCg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+
DQojaW5jbHVkZSAiZXBwbGV0LmgiDQoNCiNkZWZpbmUgTUFYQlVUVE9OIDMN
Cg0KRXBwbGV0X2dhZGdldCBjbG9zZV9idXR0b24sIGxhYmVsMSwgbGFiZWwy
LCBidXR0b24xOw0KaW50IGN1cl9idXR0b247DQp1bnNpZ25lZCBjaGFyIGJ1
dHRvbnNbTUFYQlVUVE9OXTsNCmNoYXIgY3VyYlsyXTsNCkRpc3BsYXkgKmRp
c3A7DQoNCnN0YXRpYyB2b2lkIGNsb3NlX2NiKHZvaWQgKmRhdGEpOw0Kc3Rh
dGljIHZvaWQgaW5fY2Iodm9pZCAqZGF0YSwgV2luZG93IHcpOw0Kc3RhdGlj
IHZvaWQgb3V0X2NiKHZvaWQgKmRhdGEsIFdpbmRvdyB3KTsNCnN0YXRpYyBp
bnQgZGVsZXRlX2NiKHZvaWQgKmRhdGEsIFdpbmRvdyB3aW4pOw0Kc3RhdGlj
IHZvaWQgb2tfY2Iodm9pZCAqZGF0YSk7DQoNCnN0YXRpYyB2b2lkDQpjbG9z
ZV9jYih2b2lkICpkYXRhKQ0Kew0KICBFcHBsZXRfdW5yZW1lbWJlcigpOw0K
ICBFc3luYygpOw0KICBFcHBsZXRfY2xlYW51cCgpOw0KICBkYXRhID0gTlVM
TDsNCiAgZXhpdCgwKTsNCn0NCg0Kc3RhdGljIHZvaWQNCmluX2NiKHZvaWQg
KmRhdGEsIFdpbmRvdyB3KQ0Kew0KICBpZiAodyA9PSBFcHBsZXRfZ2V0X21h
aW5fd2luZG93KCkpIHsNCiAgICBFcHBsZXRfZ2FkZ2V0X3Nob3coY2xvc2Vf
YnV0dG9uKTsNCiAgfQ0KICByZXR1cm47DQogIGRhdGEgPSBOVUxMOw0KfQ0K
DQpzdGF0aWMgdm9pZA0Kb3V0X2NiKHZvaWQgKmRhdGEsIFdpbmRvdyB3KQ0K
ew0KICBpZiAodyA9PSBFcHBsZXRfZ2V0X21haW5fd2luZG93KCkpIHsNCiAg
ICBFcHBsZXRfZ2FkZ2V0X2hpZGUoY2xvc2VfYnV0dG9uKTsNCiAgfQ0KICBy
ZXR1cm47DQogIGRhdGEgPSBOVUxMOw0KfQ0KDQpzdGF0aWMgaW50DQpkZWxl
dGVfY2Iodm9pZCAqZGF0YSwgV2luZG93IHdpbikNCnsNCiAgd2luID0gKFdp
bmRvdykgMDsNCiAgZGF0YSA9IE5VTEw7DQogIHJldHVybiAxOw0KfQ0KDQp2
b2lkDQpuZXh0X2J1dHRvbih2b2lkICpkYXRhKQ0Kew0KICAgaW50IGI7DQoN
CiAgIFhHZXRQb2ludGVyTWFwcGluZyhkaXNwLCBidXR0b25zLCBNQVhCVVRU
T04pOw0KDQogICBiID0gYnV0dG9uc1sxXTsNCiAgIGJ1dHRvbnNbMV0gPSBi
dXR0b25zWzJdOw0KICAgYnV0dG9uc1syXSA9IGJ1dHRvbnNbMF07DQogICBi
dXR0b25zWzBdID0gYjsNCg0KICAgaWYgKFhTZXRQb2ludGVyTWFwcGluZyhk
aXNwLCBidXR0b25zLCBNQVhCVVRUT04pID49IDApIHsNCgljdXJfYnV0dG9u
ID0gYnV0dG9uc1swXTsNCglFc25wcmludGYoY3VyYiwgMiwgIiVkIiwgY3Vy
X2J1dHRvbik7DQoJRXBwbGV0X2NoYW5nZV9sYWJlbChsYWJlbDIsIGN1cmIp
Ow0KICAgfQ0KfQ0KDQppbnQNCm1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2
KQ0Kew0KDQogIGF0ZXhpdChFcHBsZXRfY2xlYW51cCk7DQoNCiAgRXBwbGV0
X0luaXQoIkUtVW5pQnV0dG9uIiwgIjAuMSIsICJNb3VzZSBCdXR0b24gQ2hh
bmdlciIsIDQsMywgYXJnYywgYXJndiwgMCk7DQogIEVwcGxldF9sb2FkX2Nv
bmZpZygpOw0KDQogIGRpc3AgPSBFcHBsZXRfZ2V0X2Rpc3BsYXkoKTsNCiAg
WEdldFBvaW50ZXJNYXBwaW5nKGRpc3AsIGJ1dHRvbnMsIE1BWEJVVFRPTik7
DQogIGN1cl9idXR0b24gPSBidXR0b25zWzBdOw0KICBFc25wcmludGYoY3Vy
YiwgMiwgIiVkIiwgY3VyX2J1dHRvbik7DQoNCiAgY2xvc2VfYnV0dG9uID0g
RXBwbGV0X2NyZWF0ZV9zdGRfYnV0dG9uKCJDTE9TRSIsIDIsIDIsIGNsb3Nl
X2NiLCAodm9pZCAqKU5VTEwpOw0KICBFcHBsZXRfZ2FkZ2V0X3Nob3cobGFi
ZWwxID0gRXBwbGV0X2NyZWF0ZV9sYWJlbCg1LCAxMCwgIkJ1dHRvbjoiLCAz
KSk7DQogIEVwcGxldF9nYWRnZXRfc2hvdyhsYWJlbDIgPSBFcHBsZXRfY3Jl
YXRlX2xhYmVsKDQ4LCAxMCwgY3VyYiwgMykpOw0KICBFcHBsZXRfZ2FkZ2V0
X3Nob3coYnV0dG9uMSA9IEVwcGxldF9jcmVhdGVfdGV4dF9idXR0b24oIk5l
eHQiLCAxNSwgMjgsIDMwLCAxMiwNCgkJCQkJCQluZXh0X2J1dHRvbiwgKHZv
aWQgKilOVUxMKSk7DQoJCQkJCQkNCiAgRXBwbGV0X3JlZ2lzdGVyX2ZvY3Vz
X2luX2hhbmRsZXIoaW5fY2IsIE5VTEwpOw0KICBFcHBsZXRfcmVnaXN0ZXJf
Zm9jdXNfb3V0X2hhbmRsZXIob3V0X2NiLCBOVUxMKTsNCiAgRXBwbGV0X3Jl
Z2lzdGVyX2RlbGV0ZV9ldmVudF9oYW5kbGVyKGRlbGV0ZV9jYiwgTlVMTCk7
DQoNCiAgRXBwbGV0X3Nob3coKTsNCiAgRXBwbGV0X0xvb3AoKTsNCiAgcmV0
dXJuIDA7DQp9DQo=
---559023410-1986831816-950545598=:5900--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
