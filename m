Return-Path: <pczanik@fang.fa.gau.hu>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id 86493DDF77
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 00:27:04 +1100 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	D10B031A8D5
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 14:18:39 +0100 (CET)
Received: from [192.168.2.179] ([87.97.93.237])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KBP000HRRN3YAX0@invitel.hu> for
	linuxppc-dev@ozlabs.org; Thu, 11 Dec 2008 14:18:39 +0100 (CET)
Date: Thu, 11 Dec 2008 14:18:00 +0100
From: Peter Czanik <pczanik@fang.fa.gau.hu>
Subject: MPC8610HPCD sound as module
To: linuxppc-dev@ozlabs.org
Message-id: <49411308.1050008@fang.fa.gau.hu>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I have an MPC8610HPCD system. The latest stable kernel (2.6.27.8) runs
fine on this, with a catch: sound only works, when compiled in the
kernel (see:
http://www.alsa-project.org/db/?f=73fb074ce0b41463bb3f32aaa297a1e1f53caf2d
). When the exact same sound options are compiled as modules (see:
http://www.alsa-project.org/db/?f=c353962950284d61bd16ac7d48032b8b5f598062
), then sound card is not found. Both kernel configurations were based
on mpc8610_hpcd_defconfig with some minor tweaks (some additional fs
options to be able to boot SuSE Linux). The only difference between the
two configs is that in the second case sound is modular.

As far as I can see from comments in the sources, it should work also as
a module. Any hints how to achieve that?

Thanks, bye,
CzP
