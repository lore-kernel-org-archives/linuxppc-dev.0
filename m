Return-Path: <arrigo@vision.caltech.edu>
Received: from kla-tencor.com (smtp.kla-tencor.com [192.146.1.134])
	by ozlabs.org (Postfix) with ESMTP id 5F29D2BF08
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Oct 2004 07:45:23 +1000 (EST)
Received: from [10.35.5.214] ([10.35.5.214])
	by kla-tencor.com (8.11.6+Sun/KLAC-1.0i) with ESMTP id i9SLjEj18371
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Oct 2004 14:45:14 -0700 (PDT)
Message-ID: <41816863.9020000@vision.caltech.edu>
Date: Thu, 28 Oct 2004 14:45:07 -0700
From: Arrigo Benedetti <arrigo@vision.caltech.edu>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Disabling interrupts on a SMP system
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear all,

how can I (temporarily) disable all or some specific interrupts on a 
specific CPU in an SMP system
from user space code? In my case this is an Apple dual G5 system.

thanks
-Arrigo
