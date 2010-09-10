Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0414B70DC
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 23:18:25 +1000 (EST)
Received: from sesr04.transmode.se (sesr04.transmode.se [192.168.201.15])
	by gw1.transmode.se (Postfix) with ESMTP id 2EB4765000B
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 15:08:53 +0200 (CEST)
Subject: CONFIG_KTIME_SCALAR=y
To: linuxppc-dev@ozlabs.org
Message-ID: <OF78A6CEC4.C228A34E-ONC125779A.004771F9-C125779A.0047E674@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 10 Sep 2010 15:05:20 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Noticed that there is a CONFIG_KTIME_SCALAR knob for HIGH_RES on 32 bit
which is off for ppc. I wonder not 64 bit math on 32 bit arch is good
enough on ppc?

      Jocke
