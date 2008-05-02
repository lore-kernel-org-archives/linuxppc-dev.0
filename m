Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 79801DDF63
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 23:45:06 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 5/5] PS3: Update ps3_defconfig
Date: Fri, 2 May 2008 15:45:01 +0200
References: <20080430215644.655638516@am.sony.com>
	<4818F1E0.4010609@am.sony.com>
In-Reply-To: <4818F1E0.4010609@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805021545.01676.marvin24@gmx.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Geoff,

what about adding these defaults:
	- CONFIG_SCHED_SMT
	- CONFIG_HUGETLBFS (needed by ibm cell sdk)	


not sure about:
	- CONFIG_SPU_FS_64K_LS

Greetings

	Marvin

On Thursday 01 May 2008 00:25:36 Geoff Levand wrote:
> Update ps3_defconfig.
>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
>  arch/powerpc/configs/ps3_defconfig |  132
> +++++++++++++++++++++++-------------- 1 file changed, 84 insertions(+), 48
> deletions(-)
>
> --- a/arch/powerpc/configs/ps3_defconfig
> +++ b/arch/powerpc/configs/ps3_defconfig
> @@ -1,7 +1,7 @@
>  #
>  # Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.25-rc6
> -# Thu Mar 20 11:07:04 2008
> +# Linux kernel version: 2.6.25
> +# Mon Apr 28 12:39:10 2008
>  #
>  CONFIG_PPC64=y
> [...]
