Return-Path: <greg@kroah.com>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7AAE51007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2011 09:28:35 +1000 (EST)
Date: Thu, 22 Sep 2011 16:28:28 -0700
From: Greg KH <greg@kroah.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] drivers/tty: don't use the byte channel handle as a
	parameter in ehv_bytechan.c
Message-ID: <20110922232828.GA12088@kroah.com>
References: <1316543217-13769-1-git-send-email-timur@freescale.com>
	<20110922230640.GA16981@kroah.com> <4E7BC1A9.5050708@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E7BC1A9.5050708@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-console@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 22, 2011 at 06:15:53PM -0500, Timur Tabi wrote:
> Greg KH wrote:
> > This patch doesn't apply at all to my tty tree, what was it made
> > against?
> 
> An internal repository that supposed to be in-sync with the latest and greatest.
> 
> What's the URL for your tty-next repo?

There is no public one due to kernel.org being down.

Does your patch apply to linux-next?
