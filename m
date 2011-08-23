Return-Path: <geoff@infradead.org>
Message-ID: <4E541361.3040207@infradead.org>
Date: Tue, 23 Aug 2011 13:53:53 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH part1 v2 5/9] ps3: MEMORY_HOTPLUG is not a requirement
	anymore
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1313091073-4572-1-git-send-email-a.heider@gmail.com>
	<1313091073-4572-6-git-send-email-a.heider@gmail.com>
In-Reply-To: <1313091073-4572-6-git-send-email-a.heider@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2011 12:31 PM, Andre Heider wrote:
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
>  arch/powerpc/platforms/ps3/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
> index 476d9d9..84df5c8 100644
> --- a/arch/powerpc/platforms/ps3/Kconfig
> +++ b/arch/powerpc/platforms/ps3/Kconfig
> @@ -7,7 +7,6 @@ config PPC_PS3
>  	select USB_OHCI_BIG_ENDIAN_MMIO
>  	select USB_ARCH_HAS_EHCI
>  	select USB_EHCI_BIG_ENDIAN_MMIO
> -	select MEMORY_HOTPLUG


This one is OK, once the others are fixed up.

-Geoff
