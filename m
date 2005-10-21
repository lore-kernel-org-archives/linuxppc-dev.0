Return-Path: <cfriesen@nortel.com>
Received: from zctfs063.nortelnetworks.com (zctfs063.nortelnetworks.com
	[47.164.128.120]) by ozlabs.org (Postfix) with ESMTP id EE41D6863A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2005 15:04:00 +1000 (EST)
Message-ID: <435876B8.9000706@nortel.com>
Date: Thu, 20 Oct 2005 23:03:52 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: status of kexec for ppc on 2.6.10, any gotchas?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I've been asked to look at kexec for ppc on 2.6.10.  The syscall appears 
to be present, but there seem to be additional patches for 2.6.10-mm at:

http://www.xmission.com/~ebiederm/files/kexec/

Are these patches needed?

I haven't been able to find any current official documentation, although 
I found some old stuff from 2.5 and a writeup at:
 
http://www-128.ibm.com/developerworks/linux/library/l-kexec.html?ca=dgr-lnxw04RebootFast

Is there any official HOWTO on this?  Any issues I should look at in 
particular?

Thanks for any pointers,

Chris
