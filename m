Return-Path: <qmiao@centecnetworks.com>
Received: from centecnetworks.com (unknown [218.104.33.231])
	by ozlabs.org (Postfix) with SMTP id BC56A67BAA
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 19:32:23 +1000 (EST)
Received: from qmiao ([218.104.33.229])
	(envelope-sender <qmiao@centecnetworks.com>)
	by 192.168.25.7 with ESMTP
	for <linuxppc-embedded@ozlabs.org>; Thu, 20 Jul 2006 17:17:00 +0800
Message-ID: <010601c6abdd$442e1270$d4190a0a@centecnetworks.com>
From: "Miao Qingjun" <qmiao@centecnetworks.com>
To: <linuxppc-embedded@ozlabs.org>,
	<linuxppc-dev@ozlabs.org>
Subject: loading large lkm is so slow on ppc linux
Date: Thu, 20 Jul 2006 17:17:04 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0103_01C6AC20.52408990"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0103_01C6AC20.52408990
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64

SGksDQoNCkl0IHNlZW1zIG1vZHVsZV9mcm9iX2FyY2hfc2VjdGlvbnMoKS9jb3VudF9yZWxvY3Mo
KSBzcGVudCBzbyBtdWNoIHRpbWUgd2hlbiBsb2FkaW5nIGxhcmdlIGxrbS4NCg0KQ2FuIGp1c3Qg
InJldHVybiAwIiBpbiBwcGMgdmVyc2lvbiBvZiBtb2R1bGVfZnJvYl9hcmNoX3NlY3Rpb25zKCk/
DQpvciBqdXN0ICJyZXR1cm4gbnVtIiBpbiBjb3VudF9yZWxvY3MoKT8NCg0KdGhhbmtz

------=_NextPart_000_0103_01C6AC20.52408990
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgaHR0cC1lcXVpdj1Db250ZW50LVR5cGUgY29udGVu
dD0idGV4dC9odG1sOyBjaGFyc2V0PWdiMjMxMiI+DQo8TUVUQSBjb250ZW50PSJNU0hUTUwgNi4w
MC4yOTAwLjI2MjciIG5hbWU9R0VORVJBVE9SPg0KPFNUWUxFPjwvU1RZTEU+DQo8L0hFQUQ+DQo8
Qk9EWSBiZ0NvbG9yPSNmZmZmZmY+DQo8RElWPjxGT05UIHNpemU9Mj5IaSw8L0ZPTlQ+PC9ESVY+
DQo8RElWPjxGT05UIHNpemU9Mj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIHNpemU9
Mj5JdCBzZWVtcyBtb2R1bGVfZnJvYl9hcmNoX3NlY3Rpb25zKCkvY291bnRfcmVsb2NzKCkgc3Bl
bnQgc28gDQptdWNoIHRpbWUgd2hlbiBsb2FkaW5nIGxhcmdlIGxrbS48L0ZPTlQ+PC9ESVY+DQo8
RElWPjxGT05UIHNpemU9Mj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIHNpemU9Mj5D
YW4ganVzdCAicmV0dXJuIDAiIGluIHBwYyB2ZXJzaW9uIG9mIA0KbW9kdWxlX2Zyb2JfYXJjaF9z
ZWN0aW9ucygpPzwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPm9yIGp1c3QgInJldHVy
biBudW0iIGluIGNvdW50X3JlbG9jcygpPzwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0y
PjwvRk9OVD4mbmJzcDs8L0RJVj4NCjxESVY+PEZPTlQgc2l6ZT0yPnRoYW5rczwvRk9OVD48L0RJ
Vj48L0JPRFk+PC9IVE1MPg0K

------=_NextPart_000_0103_01C6AC20.52408990--
