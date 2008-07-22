Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.225])
	by ozlabs.org (Postfix) with ESMTP id 09668DE443
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 07:30:06 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id c8so2349711qbc.39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 14:30:05 -0700 (PDT)
Date: Tue, 22 Jul 2008 17:29:42 -0400
From: Grant Likely <grant.likely@secretlab.ca>
To: =?us-ascii?B?PT9JU08tODg1OS0xP1E/QWxicmVjaHRfRHJlPURGXw==?=
	<albrecht.dress@arcor.de>, ?=@secretlab.ca
Subject: Re: [OT] write flash on MPC5200 board via jtag
Message-ID: <20080722212941.GH12412@secretlab.ca>
References: <1216753011l.5683l.0l@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216753011l.5683l.0l@antares>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: LinuxPPC Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2008 at 08:56:43PM +0200, =?ISO-8859-1?Q?Albrecht_Dre=DF_ wrote:
> Hi,
>
> sorry for a somewhat off-topic question...
>
> I want to design a mpc5200b board which is roughly derived from  
> Freescale's 5200B Lite demo.  Obviously, I have the problem to initially 
> write u-boot into the boot nor flash.  I believe this would be possible 
> using the jtag/bsm interface (is that true?).
>
> Can you recommend any good hardware and software solution for that, if  
> possible running on linux (OSS?)?  I don't need a "real" debugger (maybe 
> an interface to gdb), just something to write the flash, so u-boot comes 
> up.

Get yourself an Abatron BDI-3000.

g.



> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
