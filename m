Return-Path: <thomas.haeberle@vipco.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.160])
	by ozlabs.org (Postfix) with ESMTP id D01ECDDFD9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 00:21:25 +1100 (EST)
Received: from [192.168.0.71] (p5B316EDC.dip.t-dialin.net [91.49.110.220])
	by post.webmailer.de (fruni mo23) (RZmta 16.15)
	with ESMTP id I07501k2KBeuPq for <linuxppc-dev@ozlabs.org>;
	Thu, 20 Mar 2008 14:09:31 +0100 (MET)
	(envelope-from: <thomas.haeberle@vipco.de>)
Message-ID: <47E2620C.4020406@vipco.de>
Date: Thu, 20 Mar 2008 14:09:33 +0100
From: =?ISO-8859-15?Q?Thomas_H=E4berle?= <thomas.haeberle@vipco.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Xenomai on TQ MPC5200
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello!

My target hardware is a MPC5200 on a TQ STK52xx.
I am developing in a Linked Setup with ELDK 3.1.1 under a Debian Linux 
(Release 2.6.18-4-686 ; gcc 4.1.2).
The whole ELDK was already used in a former project with identical 
hardware and some early tests I ran showed that it works fine (as far as 
I can see).

My goal is to get a real time Linux OS running on the target (preferably 
Xenomai) and establish a RT ethernet connection with a identical 
hardware setup (planning to use RTnet). But I am somehow stuck in the 
first place for I can't get the kernel built:
I tried quite a number of Kernel-Xenomai-Adeos-Version-combinations in 
the past four days without any actual success.

Yesterday I downloaded the Linuxppc_2_4_develop-sources from the GIT 
repository of the DENX site and set them to the exact point where the 
Adeos-Patch coming along with Xenomai 2.4.2 is build for (commit # ). 
The patch worked fine (ran trough), I configured the kernel and built 
the dependencies, but I am still unable to crosscompile the kernel and 
am also slowly running out of ideas.

I am relatively new to this part of the software world, so forgive me 
for my maybe basic questions:
I found no explicit information on the web, whether Xenomai can be run 
on my specific target at all:
Has anyone tried or knows something about that?
Or where could I check whether it is (besides asking TQ of course)?
Maybe the better way would be trying  with RTAI?
Are there any known oddities of the STK52xx and/or MPC5200?
Do I have to adapt my ELDK in any further way to get things going and 
using the DENX-sources (okay I guess this is hard to say without 
detailed information about my ELDK setup...)?
Any other helpful experience, hints or tricks?

Thanks & Greetings,
Thomas
