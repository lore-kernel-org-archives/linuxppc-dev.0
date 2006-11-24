Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6EEA67B6F
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Nov 2006 07:50:34 +1100 (EST)
Subject: Re: [PATCH 1/2] Fixed compiled issue tu to new of_platform.h header
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20061124085752.GA28049@kroah.com>
References: <11642982453599-git-send-email-nd@bplan-gmbh.de>
	<11642982461138-git-send-email-nd@bplan-gmbh.de>
	<20061124085752.GA28049@kroah.com>
Content-Type: text/plain
Date: Sat, 25 Nov 2006 07:48:35 +1100
Message-Id: <1164401315.5653.89.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, stern@rowland.harvard.edu,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-11-24 at 00:57 -0800, Greg KH wrote:
> On Thu, Nov 23, 2006 at 05:12:00PM +0100, nd@bplan-gmbh.de wrote:
> > From: Nicolas DET <nd@bplan-gmbh.de>
> 
> Hm, is this really from you?  The copyright doesn't look like it.
> 
> I need a signed-off-by: please, along with a good description of what
> the patch does.

It's from him, though he copy pasted a pile of (c) that are getting a
bit stale here without adding his own :-)

Now, Nico, since the patch has obviously a problem (thouh the problem
might be generic to the way the USB code handles multiple versions of an
HCI), it cannot be merged as-is of course.

Alan, what is your approach there ? We can't have multiple module_init()
in a single file it seems... the ugly fix is to have one with a serie of
#ifdef calling into the various HCI's but that's a big horrid.

Ben.
