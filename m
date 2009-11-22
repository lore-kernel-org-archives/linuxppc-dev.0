Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 5EDFDB7ED8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:22:11 +1100 (EST)
Received: by ywh17 with SMTP id 17so4642172ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 15:22:09 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 16:21:49 -0700
Message-ID: <fa686aa40911221521h4844db3cpb33a1afb41833d46@mail.gmail.com>
Subject: Re: [RFC PATCH 08/19] powerpc: gamecube/wii: do not include PCI
	support
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> w=
rote:
> The Nintendo GameCube and Wii video game consoles do not have PCI hardwar=
e.
> Avoid wasting their scarce memory by not including PCI support into the
> kernel.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> ---
> =A0arch/powerpc/Kconfig | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2ba14e7..84b2566 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -679,7 +679,7 @@ config PPC_PCI_CHOICE
> =A0config PCI
> =A0 =A0 =A0 =A0bool "PCI support" if PPC_PCI_CHOICE
> =A0 =A0 =A0 =A0default y if !40x && !CPM2 && !8xx && !PPC_83xx \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 && !PPC_85xx && !PPC_86xx
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && !PPC_85xx && !PPC_86xx && !GAMECUBE_COMM=
ON

phew, this is getting ugly.  But I won't ask you to clean it up.  Ack

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
