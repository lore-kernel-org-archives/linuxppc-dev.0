Return-Path: <hillel.avni@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id B845B67B7D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 20:44:55 +1000 (EST)
Received: from de01smr01.am.mot.com (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	j5GAm1Ff001062 for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 03:48:01 -0700 (MST)
Received: from zil05exm01.ea.freescale.net (zil05exm01.ea.freescale.net
	[216.3.95.200])
	by de01smr01.am.mot.com (8.13.1/8.13.0) with ESMTP id j5GAnaQF029360
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 05:49:38 -0500 (CDT)
Message-ID: <D39C8B3D64A0D511A61E00D0B7828EEA0C076452@zil05exm01.ea.freescale.net>
From: Avni Hillel-R58467 <hillel.avni@freescale.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Thu, 16 Jun 2005 13:44:48 +0300
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5725F.9DCAA450"
Cc: Kardonik Michael-R58108 <Michael.Kardonik@freescale.com>
Subject: Adding RapidIO to Linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5725F.9DCAA450
Content-Type: text/plain

Hi Matt,
 
I want to install:
 
[PATCH][1/3] RapidIO support: core
[PATCH][2/3] RapidIO support: ppc32
[PATCH][3/3] RapidIO support: net driver over messaging
 
1. What specific version of Linux should I start from?
 
2. Are there any more patches that are relevant to RIO?
 
Thanks,
 
Hillel

------_=_NextPart_001_01C5725F.9DCAA450
Content-Type: text/html
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgSFRUUC1FUVVJVj0iQ29udGVudC1UeXBlIiBDT05U
RU5UPSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXMtYXNjaWkiPg0KDQoNCjxNRVRBIGNvbnRlbnQ9Ik1T
SFRNTCA2LjAwLjI5MDAuMjYwNCIgbmFtZT1HRU5FUkFUT1I+PC9IRUFEPg0KPEJPRFk+DQo8RElW
PjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIGNsYXNzPTEwODAzMzkxMC0xNjA2MjAwNT5I
aSANCk1hdHQsPC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXpl
PTI+PFNQQU4gDQpjbGFzcz0xMDgwMzM5MTAtMTYwNjIwMDU+PC9TUEFOPjwvRk9OVD4mbmJzcDs8
L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gY2xhc3M9MTA4MDMzOTEw
LTE2MDYyMDA1Pkkgd2FudCB0byANCmluc3RhbGw6PC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+
PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gDQpjbGFzcz0xMDgwMzM5MTAtMTYwNjIwMDU+
PC9TUEFOPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+
PFNQQU4gY2xhc3M9MTA4MDMzOTEwLTE2MDYyMDA1PltQQVRDSF1bMS8zXSBSYXBpZElPIA0Kc3Vw
cG9ydDogY29yZTwvU1BBTj48L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6
ZT0yPjxTUEFOIGNsYXNzPTEwODAzMzkxMC0xNjA2MjAwNT5bUEFUQ0hdWzIvM10gUmFwaWRJTyAN
CnN1cHBvcnQ6IHBwYzMyPC9TUEFOPjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1Bcmlh
bCBzaXplPTI+PFNQQU4gY2xhc3M9MTA4MDMzOTEwLTE2MDYyMDA1PltQQVRDSF1bMy8zXSBSYXBp
ZElPIA0Kc3VwcG9ydDogbmV0IGRyaXZlciBvdmVyIG1lc3NhZ2luZzwvU1BBTj48L0ZPTlQ+PC9E
SVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIA0KY2xhc3M9MTA4MDMzOTEw
LTE2MDYyMDA1PjwvU1BBTj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJp
YWwgc2l6ZT0yPjxTUEFOIGNsYXNzPTEwODAzMzkxMC0xNjA2MjAwNT4xLiBXaGF0IHNwZWNpZmlj
IA0KdmVyc2lvbiBvZiBMaW51eCBzaG91bGQgSSBzdGFydCBmcm9tPzwvU1BBTj48L0ZPTlQ+PC9E
SVY+DQo8RElWPjxGT05UIGZhY2U9QXJpYWwgc2l6ZT0yPjxTUEFOIA0KY2xhc3M9MTA4MDMzOTEw
LTE2MDYyMDA1PjwvU1BBTj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9QXJp
YWwgc2l6ZT0yPjxTUEFOIGNsYXNzPTEwODAzMzkxMC0xNjA2MjAwNT4yLiBBcmUgdGhlcmUgYW55
IA0KbW9yZSBwYXRjaGVzIHRoYXQgYXJlIHJlbGV2YW50IHRvIFJJTz88L1NQQU4+PC9GT05UPjwv
RElWPg0KPERJVj48Rk9OVCBmYWNlPUFyaWFsIHNpemU9Mj48U1BBTiANCmNsYXNzPTEwODAzMzkx
MC0xNjA2MjAwNT48L1NQQU4+PC9GT05UPiZuYnNwOzwvRElWPg0KPERJVj48Rk9OVCBmYWNlPUFy
aWFsIHNpemU9Mj48U1BBTiANCmNsYXNzPTEwODAzMzkxMC0xNjA2MjAwNT5UaGFua3MsPC9TUEFO
PjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gDQpjbGFz
cz0xMDgwMzM5MTAtMTYwNjIwMDU+PC9TUEFOPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZP
TlQgZmFjZT1BcmlhbCBzaXplPTI+PFNQQU4gDQpjbGFzcz0xMDgwMzM5MTAtMTYwNjIwMDU+SGls
bGVsPC9TUEFOPjwvRk9OVD48L0RJVj48L0JPRFk+PC9IVE1MPg0K

------_=_NextPart_001_01C5725F.9DCAA450--
