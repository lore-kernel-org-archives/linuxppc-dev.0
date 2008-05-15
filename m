Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F3EAADDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 16:07:26 +1000 (EST)
Date: Wed, 14 May 2008 23:06:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 3/4] macintosh: replace deprecated __initcall with
	device_initcall
Message-Id: <20080514230647.15d58897.akpm@linux-foundation.org>
In-Reply-To: <18475.47278.446992.728481@cargo.ozlabs.ibm.com>
References: <200805142312.m4ENCsdu026262@imap1.linux-foundation.org>
	<18475.47278.446992.728481@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, rpjday@crashcourse.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 15 May 2008 14:14:38 +1000 Paul Mackerras <paulus@samba.org> wrote:

> akpm@linux-foundation.org writes:
> 
> > -__initcall(adb_init);
> > +device_initcall(adb_init);
> 
> There's no particular reason why this needs to go in 2.6.26, is there?
> It looks to me like something that I should queue up for 2.6.27.
> 

No, this make no difference in code generation - it's just a
use-the-modern-interface thing.
