Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Sat, 19 Jul 2008 09:44:17 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Victor Gallardo <vgallardo@amcc.com>
Subject: Re: [PATCH] Add AMCC Arches 460GT eval board support to platforms/44x
Message-ID: <20080719094417.4c49cd36@zod.rchland.ibm.com>
In-Reply-To: <18538794.post@talk.nabble.com>
References: <1216186406-27993-1-git-send-email-fkan@amcc.com>
	<20080716075025.0bca152c@zod.rchland.ibm.com>
	<18538794.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 18 Jul 2008 15:31:33 -0700 (PDT)
Victor Gallardo <vgallardo@amcc.com> wrote:

> 
> > From what I can tell, you don't even need this patch or the defconfig.
> > Nothing differs at this point from Glacier other than the DTS.  Since
> > U-Boot is your loader, it should be able to pass the different DTS to a
> > kernel that supports Cayonlands and have no issues.
> >
> > ...
> >
> > If you do want to have explicit support for Arches, that's fine.  Look
> > at how Yosemite is supported.  It just reuses Bamboo.  You could do the
> > same.
> 
> Yes, I like this idea. I'll do this.

As you might have noticed, this has generated quite a bit of discussion
on whether this is the right approach or not.  If you can wait for a
week, we plan on talking it over at OLS.  Then I can give you a better
idea as to whether we're going to stick with this or use a different
approach.

Overall your patches are fairly clean, so you've done a good job so
far.  Have a little patience with us as we figure out the right way to
go :).

josh
