Return-Path: <dibacco@libero.it>
Received: from cp-out1.libero.it (cp-out1.libero.it [212.52.84.101])
	by ozlabs.org (Postfix) with SMTP id 13ECAB7B6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 01:29:08 +1000 (EST)
Received: from wmail27 (172.31.0.38) by cp-out1.libero.it (8.5.115)
	id 4AB234230030769E for linuxppc-dev@lists.ozlabs.org;
	Mon, 21 Sep 2009 17:13:05 +0200
Message-ID: <17851044.2911671253545985517.JavaMail.root@wmail27>
Date: Mon, 21 Sep 2009 17:13:05 +0200 (CEST)
From: "dibacco@libero.it" <dibacco@libero.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: High load average  but low cpu (xenomai can be the explanation?)
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Reply-To: "dibacco@libero.it" <dibacco@libero.it>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have an MPC880 @133MHz. If I look into the load (with uptime) I get 
values around 3.0 but my CPU is always under 5 percent (top). How could I 
explain this? I'm using linux 2.6.19 with xenomai but no xenomai application is 
running at all. I have a cramfs on a nor flash. What could be the problem? If I 
kill the process I developed the average load goes down.

Thank you,
Adi
