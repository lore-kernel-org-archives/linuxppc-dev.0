Return-Path: <olaf@aepfle.de>
Received: from mo6-p00-ob.rzone.de (mo6-p00-ob.rzone.de
 [IPv6:2a01:238:20a:202:5300::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DA4D52C00B0
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2012 15:21:00 +1000 (EST)
Date: Thu, 19 Jul 2012 07:20:50 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Jingoo Han <jg1.han@samsung.com>, 'Tony Breeds' <tony@bakeyournoodle.com>
Subject: Re: [PATCH] radeonfb: Add quirk for the graphics adapter in some JSxx
Message-ID: <20120719052050.GA31783@aepfle.de>
References: <1342630144-16350-1-git-send-email-olaf@aepfle.de>
 <001201cd656b$b2794350$176bc9f0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <001201cd656b$b2794350$176bc9f0$%han@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 19, Jingoo Han wrote:

> On Thursday, July 19, 2012 1:49 AM, olaf@aepfle.de wrote:
> > From: Tony Breeds <tony@bakeyournoodle.com>
> > 
> > These devices are set to 640x480 by firmware, switch them to 800x600@60
> > so that the graphical installer can run on remote console.
> > 
> > Reported by IBM during SLES10 SP2 beta testing:
> > 
> > https://bugzilla.novell.com/show_bug.cgi?id=461002
> > LTC50817
> > 
> > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> If the author is Tony Breeds, please add 'Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>'.

He provided the initial version of the change, but did not add his tag
back in 2009. Tony, perhaps you can do that now?

Olaf
