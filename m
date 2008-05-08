Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB1E5DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 10:51:34 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m480pVuw030647
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 20:51:31 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m480pUkV181814
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 18:51:30 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m480pUnj027563
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 18:51:30 -0600
Date: Wed, 7 May 2008 19:49:57 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: All your drivers are belong to us [was WARNING: mutexes are
	preferredfor single holder semaphores]
Message-ID: <20080507194957.47abb103@zod.rchland.ibm.com>
In-Reply-To: <20080507174251.2af863d6@wally.pikatech.com>
References: <20080504204104.7eea7618@lappy.seanm.ca>
	<1209958719.21644.32.camel@pasglop>
	<20080505004023.05603b93@lappy.seanm.ca>
	<m23aouuqoh.fsf_-_@ohwell.denx.de>
	<20080507174251.2af863d6@wally.pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 7 May 2008 17:42:51 -0400
Sean MacLennan <smaclennan@pikatech.com> wrote:

> On Wed, 07 May 2008 16:36:30 +0200
> "Detlev Zundel" <dzu@denx.de> wrote:
> 
> > It also happened that a driver once posted for what the customer
> > thought was a completely specific device of his own today supports
> > lots of different boards from at least four different manufacturers."
> > 
> > The wording is of course not exact but I hope I caught the spirit of
> > what Greg wanted to say.  So yes, please post the driver - maybe Greg
> > KH will tunnel it into mainline...
> 
> I agree with the sentiment. However, it is hard enough to get
> legitimate drivers into the kernel. The drivers I mentioned do not
> come close to following the Linux kernel coding spec.

Here's the cool part.  There's this Linux driver project:

http://www.linuxdriverproject.org/twiki/bin/view

where they can take drivers like that and clean them up.  At least to a
reasonable degree.  The benefit for you is that once it's cleaned up,
it can go into the mainline kernel and it will just be there in future
releases.  Helpful when you update.

Now, I can't say I've personally ever used that project but its mission
does seem pretty targeted towards groups that want to do the right
thing with respect to drivers.  Maybe you could give it a shot and tell
others about the experience.

josh
