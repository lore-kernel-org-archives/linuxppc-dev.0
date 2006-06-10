Return-Path: <lkml@oxley.org>
Received: from anchor-fallback-95.mail.demon.net
	(anchor-fallback-95.mail.demon.net [194.217.242.82])
	by ozlabs.org (Postfix) with ESMTP id E967C67C89
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jun 2006 02:48:50 +1000 (EST)
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:2459 "EHLO
	anchor-post-34.mail.demon.net") by anchor-fallback-95.mail.demon.net
	with ESMTP id S475180AbWFJPk3 convert rfc822-to-8bit (ORCPT
	<rfc822;linuxppc-dev@ozlabs.org>); Sat, 10 Jun 2006 15:40:29 +0000
In-Reply-To: <448ADDA1.7090608@mbligh.org>
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	<448ADDA1.7090608@mbligh.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <CB1D791E-E09E-4062-AC6D-A56A5187705D@oxley.org>
From: Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.16-rc6-mm2
Date: Sat, 10 Jun 2006 16:40:24 +0100
To: unlisted-recipients:; (no To-header on input)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On 10 Jun 2006, at 15:56, Martin J. Bligh wrote:
>
> The non-PPC64 machines seem to have done a clean run for the first  
> time
> in a while ... yay!
>

Do you mean PowerBook G4 for example?
I have a been unable to compile 2.6.17-rc6-mm2 on my PowerBook.

As I, recently, reported here: http://lkml.org/lkml/2006/6/10/60

Error is:
CC      arch/powerpc/kernel/signal_32.o
arch/powerpc/kernel/signal_32.c: In function ‘handle_rt_signal’:
arch/powerpc/kernel/signal_32.c:763: error: request for member  
‘vdso_base’ in
something not a structure or union
arch/powerpc/kernel/signal_32.c:766: error: request for member  
‘vdso_base’ in
something not a structure or union
arch/powerpc/kernel/signal_32.c: In function ‘handle_signal’:
arch/powerpc/kernel/signal_32.c:1037: error: request for member  
‘vdso_base’ in
something not a structure or union
arch/powerpc/kernel/signal_32.c:1040: error: request for member  
‘vdso_base’ in
something not a structure or union
make[1]: *** [arch/powerpc/kernel/signal_32.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

Any ideas?
Thanks,
Felix
