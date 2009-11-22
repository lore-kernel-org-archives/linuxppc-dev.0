Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 61A3BB7EF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:20:37 +1100 (EST)
Received: by ywh17 with SMTP id 17so4641377ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 15:20:35 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 16:20:15 -0700
Message-ID: <fa686aa40911221520i22372282j6b619828c198d184@mail.gmail.com>
Subject: Re: [RFC PATCH 06/19] powerpc: gamecube/wii: introduce
	GAMECUBE_COMMON
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
> Add a config option GAMECUBE_COMMON to be used as a dependency for all
> options common to the Nintendo GameCube and Wii video game consoles.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

This could just be rolled into the first patch that uses it.  But
otherwise; ACK.

g.

> ---
> =A0arch/powerpc/platforms/embedded6xx/Kconfig | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/pl=
atforms/embedded6xx/Kconfig
> index 291ac9d..97a2dbc 100644
> --- a/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ b/arch/powerpc/platforms/embedded6xx/Kconfig
> @@ -90,3 +90,7 @@ config MPC10X_OPENPIC
> =A0config MPC10X_STORE_GATHERING
> =A0 =A0 =A0 =A0bool "Enable MPC10x store gathering"
> =A0 =A0 =A0 =A0depends on MPC10X_BRIDGE
> +
> +config GAMECUBE_COMMON
> + =A0 =A0 =A0 bool
> +
> --
> 1.6.3.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
