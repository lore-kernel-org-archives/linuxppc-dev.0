Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Tue, 16 Nov 2010 22:08:25 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: John Bonesio <bones@secretlab.ca>
Subject: Re: [PATCH 4/5] powerpc/5200: dts: Remove incorrect combatible strings
Message-ID: <20101117050825.GD12084@angua.secretlab.ca>
References: <20101116204917.12146.39851.stgit@riker>
	<20101116205019.12146.79445.stgit@riker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101116205019.12146.79445.stgit@riker>
Cc: jdl@jdl.com, glikely@secretlab.ca, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 16, 2010 at 12:50:19PM -0800, John Bonesio wrote:
> This patch removes some incorrect compatible strings on the local plus bus node
> in dts files for MPC5200b based systems.
> 
> Signed-off-by: John Bonesio <bones@secretlab.ca>
> ---
> 
>  arch/powerpc/boot/dts/lite5200b.dts |    2 +-
>  arch/powerpc/boot/dts/mucmc52.dts   |    2 +-
>  arch/powerpc/boot/dts/pcm032.dts    |    2 +-
>  arch/powerpc/boot/dts/uc101.dts     |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
> index c0a4e45..ed8d7ae 100644
> --- a/arch/powerpc/boot/dts/lite5200b.dts
> +++ b/arch/powerpc/boot/dts/lite5200b.dts
> @@ -295,7 +295,7 @@
>  	};
>  
>  	localbus {
> -		compatible = "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";
> +		compatible = "fsl,mpc5200b-lpb","simple-bus";

Actually, this is change backwards; all of the mpc5200b localbus nodes
should be:

	compatible = "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";


>  
>  		#address-cells = <2>;
>  		#size-cells = <1>;
> diff --git a/arch/powerpc/boot/dts/mucmc52.dts b/arch/powerpc/boot/dts/mucmc52.dts
> index 8dc212d..b9d3559 100644
> --- a/arch/powerpc/boot/dts/mucmc52.dts
> +++ b/arch/powerpc/boot/dts/mucmc52.dts
> @@ -217,7 +217,7 @@
>  	};
>  
>  	localbus {
> -		compatible = "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";
> +		compatible = "fsl,mpc5200b-lpb","simple-bus";
>  
>  		#address-cells = <2>;
>  		#size-cells = <1>;
> diff --git a/arch/powerpc/boot/dts/pcm032.dts b/arch/powerpc/boot/dts/pcm032.dts
> index e0f2702..085a646 100644
> --- a/arch/powerpc/boot/dts/pcm032.dts
> +++ b/arch/powerpc/boot/dts/pcm032.dts
> @@ -292,7 +292,7 @@
>  	};
>  
>  	localbus {
> -		compatible = "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";
> +		compatible = "fsl,mpc5200b-lpb","simple-bus";
>  
>  		#address-cells = <2>;
>  		#size-cells = <1>;
> diff --git a/arch/powerpc/boot/dts/uc101.dts b/arch/powerpc/boot/dts/uc101.dts
> index e00441a..70299a4 100644
> --- a/arch/powerpc/boot/dts/uc101.dts
> +++ b/arch/powerpc/boot/dts/uc101.dts
> @@ -229,7 +229,7 @@
>  	};
>  
>  	localbus {
> -		compatible = "fsl,mpc5200b-lpb","fsl,mpc5200-lpb","simple-bus";
> +		compatible = "fsl,mpc5200b-lpb","simple-bus";
>  
>  		#address-cells = <2>;
>  		#size-cells = <1>;
> 
