Return-Path: <Gavin.Shan@alcatel-lucent.com>
Received: from cnshjsmin03.cn.alcatel-lucent.com (unknown [211.144.215.47])
	by ozlabs.org (Postfix) with ESMTP id 341C1B7D00
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Apr 2010 13:29:19 +1100 (EST)
Message-ID: <4BB3FE05.6040800@alcatel-lucent.com>
Date: Thu, 01 Apr 2010 09:59:33 +0800
From: gshan <Gavin.Shan@alcatel-lucent.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: spin_lock_irqsave and multi-core
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I got a question when reading source code. Hope somebody can give me the 
answer.
On multi-core system, spin_lock_irqsave() can stop all CPU cores 
receiving interrupts?
If the answer is no, what we can do to disable external interrupt for 
all CPU cores?

Thanks,
Gavin
