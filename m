Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 82FC9B70DE
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Aug 2010 07:32:54 +1000 (EST)
Received: by iwn37 with SMTP id 37so481416iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 14:32:52 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <AANLkTiny_N-UqzuVaftLj75e_b0PjsdHstH8ZKx5mw7O@mail.gmail.com>
References: <20100801074831.1099.3318.stgit@angua>
	<AANLkTiny_N-UqzuVaftLj75e_b0PjsdHstH8ZKx5mw7O@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 19 Aug 2010 15:32:32 -0600
Message-ID: <AANLkTi=12oe7hquDJ4NN_S=cFdfndfxxkOmzqPziD2CE@mail.gmail.com>
Subject: Re: [PATCH] of/device: Replace struct of_device with struct
	of_platform
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, monstr@monstr.eu,
	alsa-devel mailing list <alsa-devel@alsa-project.org>,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 19, 2010 at 2:36 PM, Timur Tabi <timur@freescale.com> wrote:
> On Sun, Aug 1, 2010 at 2:57 AM, Grant Likely <grant.likely@secretlab.ca> =
wrote:
>
>> =A0sound/soc/fsl/mpc8610_hpcd.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A04 +-
>
> This file is/was significantly rewritten for 2.6.37. =A0I posted a fix
> to the alsa mailing list, but it will conflict with your patch. =A0You
> might want to remove all changes to sound/soc/fsl from this commit.

This change is already in Linus' tree.

g.
