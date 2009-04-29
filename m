Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2D62DDEEC
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 10:25:51 +1000 (EST)
Date: Tue, 28 Apr 2009 17:22:46 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please revert edada399 and 9203fc9c
In-Reply-To: <18934.35969.872225.70725@cargo.ozlabs.ibm.com>
Message-ID: <alpine.LFD.2.00.0904281722180.22156@localhost.localdomain>
References: <18934.35969.872225.70725@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Tim Abbott <tabbott@MIT.EDU>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Tue, 28 Apr 2009, Paul Mackerras wrote:
> 
> And they are clearly not fixes for regressions or serious bugs, so why
> are these patches going in after -rc3 anyway?

Yeah, my bad. They looked so obviously trivial, but obviously weren't.

I'm not taking any more of them.

		Linus
