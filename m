Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries: Enable PSTORE in pseries_defconfig
In-reply-to: <20130624064534.16842.3582.stgit@aruna-ThinkPad-T420>
References: <20130624064534.16842.3582.stgit@aruna-ThinkPad-T420>
Date: Mon, 24 Jun 2013 17:13:27 +1000
Message-ID: <31757.1372058007@ale.ozlabs.ibm.com>
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com> wrote:

> Since now we have pstore support for nvram in pseries, enable it
> in the default config. With this config option enabled, pstore
> infra-structure will be used to read/write the messages from/to nvram.
> 
> Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
>  v3:
> 	Move pstore config to right place
>  v2:
> 	Change patch description
> 
>  arch/powerpc/configs/pseries_defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
> index c4dfbaf..bea8587 100644
> --- a/arch/powerpc/configs/pseries_defconfig
> +++ b/arch/powerpc/configs/pseries_defconfig
> @@ -296,6 +296,7 @@ CONFIG_SQUASHFS=m
>  CONFIG_SQUASHFS_XATTR=y
>  CONFIG_SQUASHFS_LZO=y
>  CONFIG_SQUASHFS_XZ=y
> +CONFIG_PSTORE=y
>  CONFIG_NFS_FS=y
>  CONFIG_NFS_V3_ACL=y
>  CONFIG_NFS_V4=y
> 
