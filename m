Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 996BBB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 02:42:03 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4E970528.8080908@freescale.com>
Date: Thu, 13 Oct 2011 10:41:52 -0500
Message-Id: <E8940641-D5F9-4ADE-8892-387BB221AD71@kernel.crashing.org>
References: <1316806370-21067-1-git-send-email-agust@denx.de>
 <6EFB6D12-7505-4D3E-8FF9-033EF74FFB81@kernel.crashing.org>
 <CAOZdJXUWiatadSCmCAvMRrVjVKCJb0xo+XGsF=Rz5-Smp08tMA@mail.gmail.com>
 <6F5815DD-DBF0-4155-94CE-FEDC2C9802E1@kernel.crashing.org>
 <4E970528.8080908@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 13, 2011, at 10:35 AM, Timur Tabi wrote:

> Kumar Gala wrote:
>>>> Why did you apply this patch?  Both Scott and I rejected it.
>=20
>> Because its fixing a real issue.  If we want to remove PHYS_64BIT =
support or make it optional for the board feel free to send another =
patch.
>=20
> Ok, so if someone posts a patch that works but does things the wrong =
way, and
> that patch gets rejected during reviews, but the submitter doesn't =
post a
> follow-up patch that does things the right way, you're going to apply =
the first
> patch anyway?

Leaving the code 'broken' I consider worse than slightly improving the =
situation which the patch does.  The original patch for this board port =
introduced it with CONFIG_PHYS_64BIT set, thus I think it reasonable to =
take a patch that fixed an issue w/o anyone else putting out a patch.

If you really don't want it selected by default send me a patch to =
remove it and I'll apply.  That is far more productive than this =
discussion.

> What about the BSP team's contention that enabling 64-bit support in =
the kernel
> can drop performance by up to 25% in some situations?  We talked about =
that on
> an internal mailing list several months ago.

I think this 25% number is bogus.  There are cases where it also =
improves performance.

- k=
