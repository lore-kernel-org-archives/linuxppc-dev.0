Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 06347B7CED
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 19:56:58 +1100 (EST)
Date: Tue, 23 Mar 2010 14:25:20 +0530
From: Amit Shah <amit.shah@redhat.com>
To: =?iso-8859-1?Q?Fran=E7ois?= Diakhate <fdiakh@gmail.com>
Subject: Re: Virtio_console usage of early printk
Message-ID: <20100323085520.GF8675@amit-x200.redhat.com>
References: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (Mon) Mar 22 2010 [18:45:47], François Diakhate wrote:
> Hi all,
> 
> As far as I can see, early_put_chars is not used by virtio_console
> because it checks whether there is a port available before using it.
> If I understand correctly, this makes it useless because once we have
> a port, we can use the regular virtio transport to output things to
> the console. Does the attached patch seem valid ? Feedback from s390
> and powerpc users who use this functionality would be appreciated.
> 
> Thanks,
> François

> From 3961f380bbe84a1036ddfc823039cbee31b44dcb Mon Sep 17 00:00:00 2001
> From: =?utf-8?q?Fran=C3=A7ois=20Diakhat=C3=A9?= <fdiakh@gmail.com>
> Date: Thu, 18 Mar 2010 14:48:20 +0100
> Subject: virtio: console: Fix early_put_chars usage
> 
> Currently early_put_chars is not used by virtio_console because it can only be used once a port has been found, at which point it's too late because it is no longer needed. This patch should fix it.

You'll have to give a signed-off-by for the patch.

		Amit
