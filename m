Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7C7E4DE039
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 03:27:18 +1000 (EST)
Date: Mon, 18 May 2009 10:26:40 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [BUG] 2.6.30-rc3: BUG triggered on some hugepage usages
In-Reply-To: <20090518171322.GB13093@csn.ul.ie>
Message-ID: <alpine.LFD.2.01.0905181022420.3301@localhost.localdomain>
References: <alpine.LFD.2.00.0904212014170.3101@localhost.localdomain>
	<20090424095116.GB14283@csn.ul.ie>
	<1240586690.12551.31.camel@localhost>
	<20090430205919.GA24279@csn.ul.ie>
	<1241128126.29501.48.camel@pasglop>
	<20090518171322.GB13093@csn.ul.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ebmunson@us.ibm.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Mon, 18 May 2009, Mel Gorman wrote:
> 
> What's the story with this patch? I'm still hearing of failures with huge pages
> that this patch fixes but I'm no seeing it upstream. Was the patch
> rejected or did it just slip through the cracks?

It didn't slip through the cracks, it was apparently just delayed. It's 
part of the merge requests I've gotten today (well, strictly speaking it 
seems to have hit my inbox just before midnight yesterday, but that's 
because those silly aussies stand upside down and sleep at odd hours).

In fact, I just merged it, I haven't even had time to push that out. 

		Linus
