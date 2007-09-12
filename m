Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id ED3E4DDEA0
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 21:51:29 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 7D765221C5C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 13:51:28 +0200 (CEST)
Received: from ibook.aepfle.de (DSL01.83.171.152.220.ip-pool.NEFkom.net
	[83.171.152.220])
	by mail.mnet-online.de (Postfix) with ESMTP id 73DCD90146
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 13:51:28 +0200 (CEST)
Date: Wed, 12 Sep 2007 13:51:54 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: resume crashes with active cpufreq_userspace
Message-ID: <20070912115154.GA871@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


2.6.22.5 crashes on resume on an iBook G3 600MHz. when cpufreq_userspace is
active. System is PowerBook4,3, 750FX revision 2.3
2.6.18 crashed also on resume, but I dont know if this was the same bug.

The oopes differ. Once I get an 'Unrecoverable FP Unavailable
Exception 801' in audit_log_vformat, hald-addon-cpuf was the active task.
Only the first two function were printed in the oops backtrace.

Another one was during a pagefault in cpufreq code, while events/0 was
the active task.

Most of the time, the screen stays black with only the cursor in the
upper left corner, sometimes not even that.

Resume seems to work ok on other models, like my own ibook with 745/755
cpu, revision 51.17, PowerBook4,1
