Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 489D8DE046
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 02:10:41 +1000 (EST)
Date: Thu, 17 Jul 2008 09:10:05 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] elf loader support for auxvec base platform string
In-Reply-To: <1216276539.7740.309.camel@pasglop>
Message-ID: <alpine.LFD.1.10.0807170908060.2959@woody.linux-foundation.org>
References: <1216166331-14810-1-git-send-email-ntl@pobox.com>
	<1216166331-14810-2-git-send-email-ntl@pobox.com>
	<1216276539.7740.309.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Nathan Lynch <ntl@pobox.com>, linux-kernel@vger.kernel.org,
	roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Thu, 17 Jul 2008, Benjamin Herrenschmidt wrote:
> 
> Should I seek somebody's ack before merging a patch like the one below ?
> 
> I'm a bit reluctant to merge via the powerpc.git tree some changes to
> generic files without at least an ack from somebody else :-)

Gaah. Generally we don't, but you're right to ask. The ELF loading keeps 
on accumulating these things, and I'm not sure we have the right process 
for things like this. They're all individually small and insignificant, 
and they are all individually never going away and making the ELF loader 
messier and messier.

I dunno. 

		Linus
