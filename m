Return-Path: <arrigo@vision.caltech.edu>
Received: from kla-tencor.com (smtp.kla-tencor.com [192.146.1.134])
	by ozlabs.org (Postfix) with ESMTP id DFA0F2BDEB
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Nov 2004 12:40:42 +1100 (EST)
Received: from [10.35.5.214] ([10.35.5.214])
	by kla-tencor.com (8.11.6+Sun/KLAC-1.0i) with ESMTP id iA41efj09074
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Nov 2004 17:40:41 -0800 (PST)
Message-ID: <4189888E.5070906@vision.caltech.edu>
Date: Wed, 03 Nov 2004 17:40:30 -0800
From: Arrigo Benedetti <arrigo@vision.caltech.edu>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: problem with insmod
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

First of all I would like to thank everyone in this list who has 
answered my questions so far, especially Ben...

Now I'm trying to write and and install a kernel module on 2.6, YDL 4.0. 
I compiled the example module by
Alessandro Rubin at http://www.linux.it/~rubini/docs/modules26/src.tar.gz
When I try to load it with insmod I get:

[root@localhost root]#  insmod empty.ko
insmod: error inserting '/home/arrigo/linux/modules/src/empty.ko': -1 
Invalid module format

After some research I found that to load a module on the 2.6 kernel one 
should insmod from module-init-tools 
<ftp://ftp.it.kernel.org/pub/linux/utils/kernel/module-init-tools/>,
not the default insmod from the modutils package that comes with YDL.
So I compile and install module-init-tools, but I get the same error.
Does anyone know what's going on?

Thanks
-Arrigo
