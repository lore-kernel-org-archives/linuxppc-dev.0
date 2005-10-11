Return-Path: <peter@mcubelogics.com>
Received: from trueweb.co.kr (whois1.trueweb.co.kr [211.215.19.210])
	by ozlabs.org (Postfix) with ESMTP id E6717684C5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 15:13:27 +1000 (EST)
Message-ID: <004501c5ce10$dd668810$1801a8c0@PETER>
From: =?ks_c_5601-1987?B?wMzB2LyuXChwZXRlclwp?= <peter@mcubelogics.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Tue, 11 Oct 2005 12:07:07 +0900
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0042_01C5CE5C.4CF5FDF0"
Subject: What can I do to port JVM on MPC
Reply-To: =?ks_c_5601-1987?B?wMzB2LyuXChwZXRlclwp?= <peter@mcubelogics.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0042_01C5CE5C.4CF5FDF0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

SGkgZXZlcnlvbmUsDQpJJ20gcnVubmluZyBsaW51eCAyLjQuMjIgb24gbXkgTVBDODI3MkFEUyBi
b2FyZCB1c2luZyBNZXRyb3dlcmtzIEJTUA0KYW5kIEkgbmVlZCBKVk0gb24gaXQgdG8gZ28gZnVy
dGhlciBpbiBteSBwcm9qZWN0Lg0KQnV0IGl0J3MgdmVyeSBoYXJkIHRvIGZpbmQgYW55IGNsdWUg
Zm9yIHBvcnRpbmcgaXQuDQpBbnkgYWR2aWNlIG9yIHN0YXJ0aW5nIHBvaW50Pw0KDQpUaGFua3Mu
DQoNCnBldGVyDQo=

------=_NextPart_000_0042_01C5CE5C.4CF5FDF0
Content-Type: text/html;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgaHR0cC1lcXVpdj1Db250ZW50LVR5cGUgY29udGVu
dD0idGV4dC9odG1sOyBjaGFyc2V0PWtzX2NfNTYwMS0xOTg3Ij4NCjxNRVRBIGNvbnRlbnQ9Ik1T
SFRNTCA2LjAwLjI4MDAuMTQ3NiIgbmFtZT1HRU5FUkFUT1I+DQo8U1RZTEU+PC9TVFlMRT4NCjwv
SEVBRD4NCjxCT0RZIGJnQ29sb3I9I2ZmZmZmZj4NCjxESVY+PEZPTlQgc2l6ZT0yPg0KPERJVj48
Rk9OVCBzaXplPTI+SGkgZXZlcnlvbmUsPC9GT05UPjwvRElWPg0KPERJVj48Rk9OVCBzaXplPTI+
SSdtIHJ1bm5pbmcgbGludXggMi40LjIyIG9uIG15IE1QQzgyNzJBRFMgYm9hcmQgdXNpbmcgDQpN
ZXRyb3dlcmtzIEJTUDwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPmFuZCBJIG5lZWQg
SlZNIG9uIGl0IHRvIGdvIGZ1cnRoZXIgaW4gbXkgcHJvamVjdC48L0ZPTlQ+PC9ESVY+DQo8RElW
PjxGT05UIHNpemU9Mj5CdXQmbmJzcDtpdCdzIHZlcnkgaGFyZCB0byBmaW5kJm5ic3A7YW55Jm5i
c3A7Y2x1ZSBmb3IgcG9ydGluZyANCml0LjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0y
PkFueSBhZHZpY2Ugb3Igc3RhcnRpbmcgcG9pbnQ/PC9GT05UPjwvRElWPg0KPERJVj48Rk9OVCBz
aXplPTI+PC9GT05UPiZuYnNwOzwvRElWPg0KPERJVj48Rk9OVCBzaXplPTI+VGhhbmtzLjwvRk9O
VD48L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZP
TlQgc2l6ZT0yPnBldGVyPC9GT05UPjwvRElWPg0KPERJVj48L0ZPTlQ+Jm5ic3A7PC9ESVY+PC9E
SVY+PC9CT0RZPjwvSFRNTD4NCg==

------=_NextPart_000_0042_01C5CE5C.4CF5FDF0--
