Return-Path: <anders.gudmundsson@telia.com>
Received: from pne-smtpout2-sn2.hy.skanova.net
	(pne-smtpout2-sn2.hy.skanova.net [81.228.8.164])
	by ozlabs.org (Postfix) with ESMTP id 78941DDFD2
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 21:04:31 +1000 (EST)
Received: from [192.168.5.102] (213.66.47.229) by
	pne-smtpout2-sn2.hy.skanova.net (7.2.075)
	id 46245DE100397CF4 for linuxppc-dev@ozlabs.org;
	Tue, 1 May 2007 11:54:57 +0200
Subject: Status of snd-powermac?
From: Anders Gudmundsson <anders.gudmundsson@telia.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 01 May 2007 11:51:26 +0200
Message-Id: <1178013086.7194.24.camel@localhost.localdomain>
Mime-Version: 1.0
Reply-To: anders.gudmundsson@telia.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I hope this is the right forum for this question...
A number of TiBook/iBook users running post 2.6.20 kernels has been
affected by a bug related to the snd-powermac driver for Pmac Snapper
cards:
Ubuntu bug:
https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.20/+bug/87652
Thread on ubuntuforums:
http://ubuntuforums.org/showthread.php?t=412151

Short summary:
snd-powermac loads (specified in /etc/modules)
Sound is produced for a randomly short period never exceeding 5 seconds,
then stops. No errors are given (even if the drivers are configured with
debug), the application hangs and blocks the sound device.
No matter what versions of alsa-libs or alsa-drivers used, the bug
persists. (Only booting a pre 2.6.20 kernel helps - or using the old oss
dmasound_pmac driver) 

My question:
Is the snd-powermac driver to be phased out for the snd-aoa, and is
support planned for older cards (PB IV, G3 iBooks etc.) in snd-aoa?

Regards!
Anders
