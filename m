Return-Path: <greg@kroah.com>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F3F561007D5
 for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2011 17:38:32 +1100 (EST)
Date: Sat, 29 Oct 2011 08:38:09 +0200
From: Greg KH <greg@kroah.com>
To: "Hans J. Koch" <hjk@hansjkoch.de>
Subject: Re: [RFC][PATCH 1/2] uio: allow drivers to override the pgprot for
 mmap
Message-ID: <20111029063809.GC2280@kroah.com>
References: <1319817030-23992-1-git-send-email-galak@kernel.crashing.org>
 <20111028214812.GD23092@local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111028214812.GD23092@local>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 28, 2011 at 11:48:12PM +0200, Hans J. Koch wrote:
> On Fri, Oct 28, 2011 at 10:50:29AM -0500, Kumar Gala wrote:
> > For some devices, the default behavior of pgprot_noncached() is not
> > appropriate for all of its mappable regions. This provides a means for
> > the kernel side of the UIO driver to override the flags without having
> > to implement its own full mmap callback.
> 
> Thanks for also providing an example driver showing the use of this.
> You should also post this driver in a mainline-ready version, I'm a bit
> uncomfortable with adding a new function pointer without having any users.

I'm more than "uncomfortable", I'll refuse to take any such patch unless
there is a in-kernel user, otherwise it makes no sense to add the
pointer at all.

thanks,

greg k-h
