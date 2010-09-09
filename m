Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 99C4BB6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Sep 2010 16:36:05 +1000 (EST)
To: Tirumala Marri <tmarri@apm.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Combining defconfigs for 44x based boards
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <49073d172310031addb3aa7d08a60c99@mail.gmail.com>
References: <a3a9eb5a2e770f931950ad13c01960da@mail.gmail.com>
	<20100909004853.GA11808@zod.rchland.ibm.com>
	<49073d172310031addb3aa7d08a60c99@mail.gmail.com>
Date: Thu, 09 Sep 2010 08:36:00 +0200
Message-Id: <20100909063601.03CCE1506AA@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Tirumala Marri,

In message <49073d172310031addb3aa7d08a60c99@mail.gmail.com> you wrote:
>
> I am thinking that we can combine arches, Canyonlands, glacier, redwood
> and eiger can be combined as ppc46x_defconfig.

We already have arch/powerpc/configs/ppc40x_defconfig and
arch/powerpc/configs/ppc44x_defconfig in mainline.

What's wrong with using these?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
CONSUMER NOTICE:  Because  of  the  "Uncertainty  Principle,"  It  Is
Impossible  for  the  Consumer  to  Find  Out  at  the Same Time Both
Precisely Where This Product Is and How Fast It Is Moving.
