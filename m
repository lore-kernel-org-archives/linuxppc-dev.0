Return-Path: <j.glisse@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.206])
	by ozlabs.org (Postfix) with ESMTP id E5E7367A6D
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 01:18:07 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so1406306wra
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Apr 2005 08:18:06 -0700 (PDT)
Message-ID: <4240b91605040508172fff1f97@mail.gmail.com>
Date: Tue, 5 Apr 2005 16:17:51 +0100
From: Jerome Glisse <j.glisse@gmail.com>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je1x9pv1mf.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4240b916050404033230db0551@mail.gmail.com>
	<1112618509.26086.68.camel@gaston>
	<4240b91605040412117b29d4ca@mail.gmail.com>
	<1112656372.26086.88.camel@gaston>
	<4240b91605040504525fd877e5@mail.gmail.com>
	<je1x9pv1mf.fsf@sykes.suse.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: linux 2.6.12-rc1-bk5 compilation error
Reply-To: Jerome Glisse <j.glisse@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Apr 5, 2005 1:39 PM, Andreas Schwab <schwab@suse.de> wrote:
> Jerome Glisse <j.glisse@gmail.com> writes:
> 
> > I will try t look at radeon framebuffer see if i can find anythings.
> > Any idea of which change on that code may be the origin of this ?
> 
> I'd suggest looking at the changes between rc1 and rc2 first.  On my iBook
> G3 with Radeon M6 I'm also having problems with rc2, whereas rc1 is
> working fine.  I haven't found the time to look closer yet.
> 
> Andreas.

Shame on me, i was passing wrong arguments to the kernel
now this works...

Jerome Glisse
