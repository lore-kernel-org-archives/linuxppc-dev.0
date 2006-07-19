Return-Path: <zaitcev@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 24B4667B87
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 05:19:49 +1000 (EST)
Date: Wed, 19 Jul 2006 12:19:22 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Li Yang" <LeoLi@freescale.com>
Subject: Re: [linux-usb-devel] [PATCH] Add USB to MPC8349 PB platform support
Message-Id: <20060719121922.ef989b1d.zaitcev@redhat.com>
In-Reply-To: <a0bc9bf80607191159l679ce8ddm35a30236a9d887c7@mail.gmail.com>
References: <4879B0C6C249214CBE7AB04453F84E4D050B55@zch01exm20.fsl.freescale.net>
	<4856A73A-BB23-4850-A697-1CE7C385DE42@kernel.crashing.org>
	<1E6652B1-3126-4B69-BE9D-8DCE8DCACE7C@embeddedalley.com>
	<a0bc9bf80607191159l679ce8ddm35a30236a9d887c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, zaitcev@redhat.com,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Jul 2006 02:59:44 +0800, "Li Yang" <LeoLi@freescale.com> wrote:

> But why?  Most embedded products facing end-user wouldn't like users
> to modify the system by themselves.

Certainly vendors won't like to give consumers extra freedoms.
However, consumers like those freedoms, even if they would not
use them in any specific instance.

>  Sometimes they even put effort in preventing user to do so.

Jerks and criminals, that's what they are. Why would Linux developers
care about needs of these people?

Free software is about protecting the rights of users against
vendors who "wouldn't like" users doing what they want with the
product they bought.

> The only kind of products I can think of, which
> want the users to modify the code is reference boards, IMHO.

Ever heard of WRT54? But in fact, every product out there may provide
its owner an additional value when customized. I'd love to fix some
bugs in my microwave, for instance. The silly thing will not start
the timer if the door is open. It probably uses the same function
which prevents cooking from starting (it also has a hardware interlock
that cuts the magnetron, but this is different).

-- Pete
