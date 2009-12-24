Return-Path: <Gavin.Shan@alcatel-lucent.com>
Received: from cnshjsmin03.cn.alcatel-lucent.com
	(cnmailgate04.alcatel-sbell.com.cn [211.144.215.47])
	by ozlabs.org (Postfix) with ESMTP id 15166B7B93
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Dec 2009 06:05:33 +1100 (EST)
Message-ID: <4B33197D.9000506@alcatel-lucent.com>
Date: Thu, 24 Dec 2009 02:34:21 -0500
From: gshan <gshan@alcatel-lucent.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: xmon & SCSI ATA devices
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

xmon and SCSI SATA device driver were installed on my system. When I invoked
xmon explicitly for kernel debugging, there're probably pending SCSI 
requests issued.
So those SCSI requests complained timeout when I quited from xmon. I want to
find a way to suspend SCSI device before invoking xmon and resume that 
before
quiting from xmon. Anybody knew there is a way to do this?

Thanks,
Gavin
