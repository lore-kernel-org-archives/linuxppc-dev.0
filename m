Return-Path: <lada.podivin@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AD84AB70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 10:12:34 +1000 (EST)
Received: from mail-bw0-f208.google.com (mail-bw0-f208.google.com
	[209.85.218.208]) by ozlabs.org (Postfix) with ESMTP id EED8CDDDE7
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 00:05:32 +1000 (EST)
Received: by bwz4 with SMTP id 4so170546bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 07:05:30 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 30 Jun 2009 15:58:53 +0200
Message-ID: <e35801cc0906300658q45d5ea00ub939ba73185efd72@mail.gmail.com>
Subject: ppc405ex + gigabit ethernet
From: Lada Podivin <lada.podivin@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0016e6d7845b031cce046d913502
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6d7845b031cce046d913502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I benchmarked performance of my network, which contains ppc405EX (Kilauea
board, kernel 2.6.30 from Denx) connected with a linux desktop via gigabit
ethernet. I used the netperf tool:

netperf -t UDP_STREAM -H 192.168.1.1 -- -m 32768

So I was sending UDP packets to the desktop. The resulting speed was about
370 Kb/s. I tried to send the packets to several different computers - with
the same result. So the ppc board is the bottleneck in this case.

Is there any possibility to improve the gigabit capabilities of the
ppc405EX? Is there anyone who achieved a better performance with ppc4xx
boards?

Thanks!

Best,
Lada Podivin

--0016e6d7845b031cce046d913502
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,<br><br>I benchmarked performance of my network, which contains ppc405EX (Kilauea board, kernel 2.6.30 from Denx) connected with a linux desktop via gigabit ethernet. I used the netperf tool: <br><br>netperf -t UDP_STREAM -H 192.168.1.1 -- -m 32768<br>
<br>So I was sending UDP packets to the desktop. The resulting speed was about 370 Kb/s. I tried to send the packets to several different computers - with the same result. So the ppc board is the bottleneck in this case.<br>
<br>Is there any possibility to improve the gigabit capabilities of the ppc405EX? Is there anyone who achieved a better performance with ppc4xx boards?<br><br>Thanks!<br><br>Best,<br>Lada Podivin<br><br>

--0016e6d7845b031cce046d913502--
