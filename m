From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15251.459.153586.712142@cargo.ozlabs.ibm.com>
Date: Mon, 3 Sep 2001 14:06:35 +1000 (EST)
To: Edward Swarthout <swarthou@ibmoto.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Assorted patches - number one
In-Reply-To: <200108311711.f7VHBxS14716@pacific.somerset.sps.mot.com>
References: <200108311711.f7VHBxS14716@pacific.somerset.sps.mot.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Edward Swarthout writes:

> I broke up my proposed set of patches into pieces.

Thanks.  This one looks OK except for some glitches -

> +#define	SPRN_IABR	0x3F2	/* Instruction Address Breakpoint Register */
>  #define	SPRN_IABR	0x3F2	/* Instruction Address Breakpoint Register */

you're adding a duplicate line here

> +#define	SPRN_TBHI	0x3DC	/* Time Base High */
> +#define	SPRN_TBHU	0x3CC	/* Time Base High User-mode */
> +#define	SPRN_TBLO	0x3DD	/* Time Base Low */
> +#define	SPRN_TBLU	0x3CD	/* Time Base Low User-mode */

These are the 4xx registers, aren't they?  We had definitions in like
this before, does anyone remember why they were removed?

> +#define	SPRN_PTEHI	0x3D5	/* 981 7450 PTEHI */
> +#define	SPRN_PTELO	0x3D6	/* 982 7450 PTELO */
> +#define	SPRN_ICTRL 	0x3F3	/* 1011 7450 ICTRL */
> +#define   ICTRL_EICE         (0x08000000)   /* EICE */
> +#define   ICTRL_EDCE         (0x04000000)   /* EIDE */
> +#define   ICTRL_EICP         (0x00000100)   /* EICP */
> +#define	SPRN_LDSTDB	0x3F4	/* 1012 7450 LDSTDB */

these comments could be more informative :)

I'll take the patch and fix the glitches but it would be good if you
could check your next patch carefully.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
