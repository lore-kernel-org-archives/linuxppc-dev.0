Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id D92CFB7CEF
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 16:03:02 +1100 (EST)
Date: Fri, 26 Mar 2010 10:31:09 +0530
From: Amit Shah <amit.shah@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with multiple hvc consoles via virtio-console
Message-ID: <20100326050109.GK8111@amit-x200.redhat.com>
References: <20100324153408.GB18581@amit-x200.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100324153408.GB18581@amit-x200.redhat.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (Wed) Mar 24 2010 [21:04:08], Amit Shah wrote:
> Hello,
> 
> When multiple hvc console ports are initialised and used via the
> virtio_console driver, I can interact with only the first console, the
> 2nd one doesn't respond.
> 
> If I call hvc_kick() even if hvc_poll() returns 0, the 2nd console
> becomes responsive.

Actually it's not that fancy: if I login to the first console (hvc0) and
then spawn another one (hvc1), I can't login into hvc1. If I spawn hvc1
before logging into hvc0, I can work with both.

		Amit
