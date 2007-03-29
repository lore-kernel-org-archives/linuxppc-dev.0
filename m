Return-Path: <torvalds@linux-foundation.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1E67DDED8
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2007 06:15:19 +1000 (EST)
Date: Thu, 29 Mar 2007 13:14:36 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_linus' branch
In-Reply-To: <Pine.LNX.4.64.0703291434500.23408@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0703291311110.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703291434500.23408@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Thu, 29 Mar 2007, Kumar Gala wrote:
> 
> Please pull from 'for_linus' branch of
> master.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git

Please don't do this to me.

 - give a valid URL! 

   You could have either added a "ssh://" to before that string, or used a 
   colon between the hostname and the path, but the URL you quoted is 
   broken.

 - put the branch-name after the URL on the same line, so that I can 
   cut-and-paste them together rather than separately (and so that I don't 
   miss the fact that it wasn't the default branch)

IOW, it should have said

  Please pull from the 'for_linus' branch at

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for_linus

or something similar.

Thanks from your anal and grumpy kernel maintainer,

		Linus
