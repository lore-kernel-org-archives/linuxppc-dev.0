From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 4 Mar 2003 12:51:01 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Trivial patch to add PVR_7455
Message-ID: <20030304195101.GA4635@rover.farnsworth.org>
References: <20030304190421.GA4490@rover.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030304190421.GA4490@rover.farnsworth.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 04, 2003 at 07:04:22PM +0000, Dale Farnsworth wrote:
> ===== include/asm-ppc/processor.h 1.80 vs edited =====
> --- 1.80/include/asm-ppc/processor.h	Thu Feb 27 13:22:28 2003
> +++ edited/include/asm-ppc/processor.h	Tue Mar  4 11:02:35 2003
> @@ -687,6 +687,7 @@
>  #define	PVR_7400	0x000C0000
>  #define	PVR_7410	0x800C0000
>  #define	PVR_7450	0x80000000
> +#define	PVR_7455	0x80010000
>  /*
>   * For the 8xx processors, all of them report the same PVR family for
>   * the PowerPC core. The various versions of these processors must be

I'm told that using PVR_XXXX is deprecated and that in my case
I'd be better off using CPU_FTR_L3CR.

So, nevermind.

-Dale

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
