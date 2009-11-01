Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 4DAC8B7C4E
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Nov 2009 18:13:03 +1100 (EST)
Received: by ywh37 with SMTP id 37so4268991ywh.17
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Nov 2009 00:13:02 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1255075865-4025-2-git-send-email-niklaus.giger@member.fsf.org>
References: <1255075865-4025-1-git-send-email-niklaus.giger@member.fsf.org>
	<1255075865-4025-2-git-send-email-niklaus.giger@member.fsf.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 1 Nov 2009 01:12:42 -0600
Message-ID: <fa686aa40911010012g66f46950n4330e9d564b7c420@mail.gmail.com>
Subject: Re: [PATCH 1/1] powerpc/40x: Add new PPC440EPx based board HCU5 of
	Netstal Maschinen
To: Niklaus Giger <niklaus.giger@member.fsf.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, niklaus.giger@netstal.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 9, 2009 at 2:11 AM, Niklaus Giger
<niklaus.giger@member.fsf.org> wrote:
> Adds support for a HCU5 PPC405EPx based board from Netstal Maschinen AG.
>
> Signed-off-by: Niklaus Giger <niklaus.giger@member.fsf.org>
> ---
> =A0arch/powerpc/boot/dts/hcu5.dts =A0 =A0 =A0 =A0 =A0| =A0254 +++++++
> =A0arch/powerpc/configs/44x/hcu5_defconfig | 1166 +++++++++++++++++++++++=
++++++++

Do you really need your own defconfig?  Can you instead add support
for your board to ppc44x_defconfig?  Josh is the maintainer here, so
it is his decision, but on 5200 stuff I've been pushing back on adding
yet-another-board-specific-defconfig when there isn't a really
compelling reason to do so.  It adds a lot of lines for not a lot of
benefit.  Besides, if you add your board to the ppc44x_defconfig, you
gain the advantage of your code getting compiled by others more
frequently.

g.
