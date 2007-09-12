Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <556445368AFA1C438794ABDA8901891C066B5BD4@USA0300MS03.na.xerox.net>
References: <556445368AFA1C438794ABDA8901891C066B5BD4@USA0300MS03.na.xerox.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3BEB1230-5FE7-48EF-998C-B46ACC51E6B6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 7448 pll registers
Date: Wed, 12 Sep 2007 17:57:03 -0500
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 5, 2007, at 4:24 PM, Leisner, Martin wrote:

> I'm going to get DFS into the 7448 (it looks like I'm going to take a
> different
> tactic then I see in 2.6.20.16 -- it hinges on powermac, and I don't
> know if it
> even compiles).
>
> In include/asm-powerpc, its missing definitions for HID1/{PC4,PC5}.
>
> bash2 :2 mleisner@linuxcom-01 05:18:58; rcsdiff -u reg.h
> ===================================================================
> RCS file: reg.h,v
> retrieving revision 1.1
> diff -u -r1.1 reg.h
> --- reg.h       2007/09/05 20:45:36     1.1
> +++ reg.h       2007/09/05 20:46:56
> @@ -253,6 +253,8 @@
>  #define HID1_PC1       (1<<15)         /* 7450 PLL_CFG[1] */
>  #define HID1_PC2       (1<<14)         /* 7450 PLL_CFG[2] */
>  #define HID1_PC3       (1<<13)         /* 7450 PLL_CFG[3] */
> +#define HID1_PC4       (1<<12)         /* ???? PLL_CFG[4] */

7455 for PLL_CFG[4]

> +#define HID1_PC5       (1<<17)         /* 7448 specific bit --
> PLL_CFG[5] */
>  #define HID1_SYNCBE    (1<<11)         /* 7450 ABE for sync, eieio */
>  #define HID1_ABE       (1<<10)         /* 7450 Address Broadcast  
> Enable
> */
>  #define HID1_PS                (1<<16)         /* 750FX PLL selection
> */
>
>
> PC4 seems "generic", PC5 is a "MPC7448 specific bit"
>
> I'm not sure what HID1_PS means ( 750FX PLL selection ), its the same
> bit as
> HID1_PC0.

Do you want this patch in the kernel?  If so we'll need a signed-off-by.

- k
