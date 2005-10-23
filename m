Return-Path: <info@moreframe.com>
Received: from mxvip28.hichina.com (unknown [218.30.102.158])
	by ozlabs.org (Postfix) with ESMTP id 44244685A0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Oct 2005 01:45:05 +1000 (EST)
Received: from 203.88.32.9 (HELO sz?hw?swordz) (envelope-from
	info@moreframe.com)
	by mxvip28.hichina.com (quarkmail-1.2.1) with ESMTP id S5757078AbVJWPiS
	for linuxppc-embedded@ozlabs.org; Sun, 23 Oct 2005 23:38:18 +0800
Date: Sun, 23 Oct 2005 23:39:00 +0800
From: "info" <info@moreframe.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon080416012840_====="
Message-ID: <1130081898$57509$59788830@info@moreframe.com>
Subject: RE:Help needed Linux-2.6 - MPC8541
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

--=====003_Dragon080416012840_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Junita

Sorry to disturbed you. I find your question in the http://ozlabs.org mail list.
Have you fixed the bug in gianfar_phy.c? 
tempval = gfar_read(&priv-> regs-> dmactrl);
tempval |= (DMACTRL_GRS | DMACTRL_GTS);
gfar_write(&priv-> regs-> dmactrl, tempval);

while (!(gfar_read(&priv-> regs-> ievent) & (IEVENT_GRSC | IEVENT_GTSC)))
cpu_relax();

/* Reset MAC layer */
gfar_write(&priv-> regs-> maccfg1, MACCFG1_SOFT_RESET);

I buy a RMC-G8500 card from GDAtech, I try to build linux-2.6.13.4 from kernel.org and meet the same problems as you had. I test the same code on freescale 8540_ADS board, it is good.Can you share some infomation of your progress?

Thank you!
Jian

--=====003_Dragon080416012840_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgaHR0cC1lcXVpdj1Db250ZW50LVR5cGUgY29udGVu
dD0idGV4dC9odG1sOyBjaGFyc2V0PWdiMjMxMiI+DQo8TUVUQSBjb250ZW50PSJNU0hUTUwgNi4w
MC4yOTAwLjI2MjciIG5hbWU9R0VORVJBVE9SPjwvSEVBRD4NCjxCT0RZPjxGT05UIGZhY2U9y87M
5T4NCjxESVY+SnVuaXRhPC9ESVY+DQo8RElWPiZuYnNwOzwvRElWPg0KPERJVj5Tb3JyeSB0byBk
aXN0dXJiZWQgeW91LiBJIGZpbmQgeW91ciBxdWVzdGlvbiBpbiB0aGUgPEEgDQpocmVmPSJodHRw
Oi8vb3psYWJzLm9yZyI+aHR0cDovL296bGFicy5vcmc8L0E+Jm5ic3A7bWFpbCBsaXN0LjwvRElW
Pg0KPERJVj48Rk9OVCBzaXplPTI+PEZPTlQgDQpzaXplPTM+SGF2ZSZuYnNwO3lvdSZuYnNwO2Zp
eGVkJm5ic3A7dGhlJm5ic3A7YnVnJm5ic3A7aW4mbmJzcDtnaWFuZmFyX3BoeS5jPzwvRk9OVD4m
bmJzcDs8L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIGNvbG9yPSMwMDAwODAgc2l6ZT0yPnRlbXB2
YWwmbmJzcDs9Jm5ic3A7Z2Zhcl9yZWFkKCZhbXA7cHJpdi0mZ3Q7IA0KcmVncy0mZ3Q7IGRtYWN0
cmwpOzwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgY29sb3I9IzAwMDA4MCANCnNpemU9Mj50ZW1w
dmFsJm5ic3A7fD0mbmJzcDsoRE1BQ1RSTF9HUlMmbmJzcDt8Jm5ic3A7RE1BQ1RSTF9HVFMpOzwv
Rk9OVD48L0RJVj4NCjxESVY+PEZPTlQgY29sb3I9IzAwMDA4MCBzaXplPTI+Z2Zhcl93cml0ZSgm
YW1wO3ByaXYtJmd0OyByZWdzLSZndDsgDQpkbWFjdHJsLCZuYnNwO3RlbXB2YWwpOzwvRk9OVD48
L0RJVj4NCjxESVY+PEZPTlQgY29sb3I9IzAwMDA4MCBzaXplPTI+PC9GT05UPiZuYnNwOzwvRElW
Pg0KPERJVj48Rk9OVCBjb2xvcj0jODAwMDAwIHNpemU9Mj53aGlsZSZuYnNwOyghKGdmYXJfcmVh
ZCgmYW1wO3ByaXYtJmd0OyByZWdzLSZndDsgDQppZXZlbnQpJm5ic3A7JmFtcDsmbmJzcDsoSUVW
RU5UX0dSU0MmbmJzcDt8Jm5ic3A7SUVWRU5UX0dUU0MpKSk8L0ZPTlQ+PC9ESVY+DQo8RElWPjxG
T05UIGNvbG9yPSM4MDAwMDAgc2l6ZT0yPmNwdV9yZWxheCgpOzwvRk9OVD48L0RJVj4NCjxESVY+
PEZPTlQgY29sb3I9IzAwMDA4MCBzaXplPTI+PC9GT05UPiZuYnNwOzwvRElWPg0KPERJVj48Rk9O
VCBjb2xvcj0jMDAwMDgwIA0Kc2l6ZT0yPi8qJm5ic3A7UmVzZXQmbmJzcDtNQUMmbmJzcDtsYXll
ciZuYnNwOyovPC9GT05UPjwvRElWPg0KPERJVj48Rk9OVCBjb2xvcj0jMDAwMDgwIHNpemU9Mj5n
ZmFyX3dyaXRlKCZhbXA7cHJpdi0mZ3Q7IHJlZ3MtJmd0OyANCm1hY2NmZzEsJm5ic3A7TUFDQ0ZH
MV9TT0ZUX1JFU0VUKTs8L0ZPTlQ+PC9ESVY+DQo8RElWPjxGT05UIGNvbG9yPSMwMDAwODAgc2l6
ZT0yPjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPjxGT05UIHNpemU9Mz5J
IGJ1eSBhIFJNQy1HODUwMCBjYXJkIGZyb20gR0RBdGVjaCwgSSB0cnkgdG8gDQpidWlsZCBsaW51
eC0yLjYuMTMuNCBmcm9tIGtlcm5lbC5vcmcgYW5kIG1lZXQgdGhlIHNhbWUgcHJvYmxlbXMgYXMg
eW91IGhhZC4gSSANCnRlc3QgdGhlIHNhbWUgY29kZSBvbiBmcmVlc2NhbGUgODU0MF9BRFMgYm9h
cmQsIGl0IGlzIGdvb2QuQ2FuIHlvdSBzaGFyZSBzb21lIA0KaW5mb21hdGlvbiBvZiB5b3VyIHBy
b2dyZXNzPzwvRk9OVD48L0ZPTlQ+PC9ESVY+DQo8RElWPiZuYnNwOzwvRElWPg0KPERJVj5UaGFu
ayB5b3UhPC9ESVY+DQo8RElWPkppYW48L0RJVj48L0ZPTlQ+PC9CT0RZPjwvSFRNTD4NCg==

--=====003_Dragon080416012840_=====--
