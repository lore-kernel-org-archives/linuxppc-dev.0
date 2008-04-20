Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C22ADE316
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 Apr 2008 11:05:15 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JnNfy-0002yW-NK
	for linuxppc-embedded@ozlabs.org; Sun, 20 Apr 2008 00:45:03 +0000
Received: from 65.161.19.125 ([65.161.19.125])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sun, 20 Apr 2008 00:45:02 +0000
Received: from dwayne.fontenot by 65.161.19.125 with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Sun, 20 Apr 2008 00:45:02 +0000
To: linuxppc-embedded@ozlabs.org
From: Dwayne Fontenot <dwayne.fontenot@att.net>
Subject: Re: removal of arch/ppc in 2.6.27?
Date: Sun, 20 Apr 2008 00:39:49 +0000 (UTC)
Message-ID: <loom.20080420T003504-90@post.gmane.org>
References: <D713F373-AE2A-4341-9C29-EF65B9399B36@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala <galak <at> kernel.crashing.org> writes:

> 
> This is intended as a reminder that we plan on getting rid of arch/ppc  
> this summer.  I'm guessing based on kernel release times that will be  
> 2.6.27.  That would mean 2.6.26 will be the last kernel to support  
> arch/ppc.
> 
> If people have boards that like ported over please let us know and  
> work with us to port this over to arch/powerpc.
> 
> Here is a list based on arch/ppc/platforms.  Its not intended to be  
> complete but a general idea of what's left in arch/ppc.
> 
...
> MVME5100        e6xx

I would very much like to see mvme5100 move to powerpc.

I'll help any way I can including trying to port it myself.

Is it significant that in arch/powerpc/platforms/prep/Kconfig
PPC_PREP depends on BROKEN ?
What are the implications of that?

Thanks,

Dwayne
