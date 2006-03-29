Return-Path: <Josef.Angermeier@informatik.uni-erlangen.de>
Received: from max72.rrze.uni-erlangen.de (max72.rrze.uni-erlangen.de
	[131.188.3.69]) by ozlabs.org (Postfix) with ESMTP id D3E85679F7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Mar 2006 19:22:53 +1100 (EST)
Received: from fau-vscan-2.rrze.uni-erlangen.de ([131.188.3.69]
	[131.188.3.69]) by faurelaysmart-2.rrze.uni-erlangen.de with
	ESMTP for linuxppc-embedded@ozlabs.org;
	Wed, 29 Mar 2006 10:22:31 +0200
Received: from max72.rrze.uni-erlangen.de ([131.188.3.69])
	by fau-vscan-2.rrze.uni-erlangen.de (fau-vscan-2.rrze.uni-erlangen.de
	[131.188.2.92]) (amavisd-new)
	with ESMTP id 28121-03 for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Mar 2006 10:22:31 +0200 (MEST)
Received: from [131.188.51.43] ([131.188.51.43] [131.188.51.43]) by
	smtp-auth.uni-erlangen.de with ESMTP for
	linuxppc-embedded@ozlabs.org; Wed, 29 Mar 2006 10:22:30 +0200
Message-Id: <442A43C6.5050605@cs.fau.de>
Date: Wed, 29 Mar 2006 10:22:30 +0200
From: Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: "lseek/write char driver" versus "usermode iomem access"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

besides adapting linux to my custom board, i now have to write a driver 
for a special device. This device mainly consists of an up to 512 bytes 
big IO memory. Because performance matters alot, i wonder if i shall 
write a simple char driver offering a write/lseek-interface to access 
this memory or if i shall do something new to me, mapping the IO-memory 
to the userspace, so that the user-program can directly access the 
device memory. Can anyone tell me how performance probably differs 
between those two design.

Thanks, you probably save me alot of time to tryout!

Josef
