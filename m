Return-Path: <rober@opnet.com.tw>
Received: from opnet2.opnet.com.tw (unknown [210.243.240.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85872688F8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Dec 2005 20:49:32 +1100 (EST)
Received: from [10.0.14.26] (h248-210-243-240.opnet.com.tw [210.243.240.248]
	(may be forged))
	by opnet2.opnet.com.tw (8.13.4/8.13.1) with ESMTP id jBMHsZxt046332
	for <linuxppc-embedded@ozlabs.org>; Thu, 22 Dec 2005 17:54:39 GMT
	(envelope-from rober@opnet.com.tw)
From: =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?=
	<rober@opnet.com.tw>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Thu, 22 Dec 2005 17:40:41 +0800
Message-Id: <1135244441.24562.5.camel@banana>
Mime-Version: 1.0
Subject: Bridge function at Linux 2.4.25
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:
     I used Linux 2.4.25 at my custom MPC852T board.I got some problem
after enable 802.1d bridge function.Why?

    Anybody know which version of brctl is suitable for Linux 2.4.25?(I
used bridge-utils-1.0.6.)

NETDEV WATCHDOG: eth1: transmit timed out
eth1: transmit timed out.
Ring data dump: cur_tx c30bd100, tx_free 0, dirty_tx c30bd100, cur_rx
c30bd000
 tx: 16 buffers
  c30bd100: 9c00 003c 01ba5a70
  c30bd108: 9c00 003c 01ba5b70
  c30bd110: 9c00 003c 01ba5c70
  c30bd118: 9c00 003c 01ba5d70
  c30bd120: 9c00 0071 01ba5e70
  c30bd128: 9c00 006e 00880080
  c30bd130: 9c00 0076 00880180
