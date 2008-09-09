Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id BA9E7DDFA1
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 00:04:29 +1000 (EST)
Received: by gxk14 with SMTP id 14so10294745gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Sep 2008 07:04:27 -0700 (PDT)
Date: Tue, 9 Sep 2008 10:03:37 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Re: [PATCH] powerpc: Holly board needs dtbImage target
Message-ID: <20080909140337.GB15005@yoda.jdub.homelinux.org>
References: <20080909140028.GA15005@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080909140028.GA15005@yoda.jdub.homelinux.org>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2008 at 10:00:28AM -0400, Josh Boyer wrote:
>One of the changes in the bootwrapper makefile introduced the dtbImage targets
>for boards that need a simple zImage with a DTB embedded in them.  When this
>was done, it broke booting on the Holly board as the zImage.holly wrapper did
>not get the DTB embedded properly.
>
>This patch changes the target for the Holly board to a dtbImage so that the
>wrapper includes the vmlinux, wrapper bits, and DTB.
>
>Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Paul, this should go into 2.6.27.  The Holly board doesn't boot without it.

josh
