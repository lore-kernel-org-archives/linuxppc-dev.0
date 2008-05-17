Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id AC335DDF02
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 May 2008 05:32:00 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so406770anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 May 2008 12:31:58 -0700 (PDT)
Message-ID: <fa686aa40805171231xa067188y443ddced0ec42030@mail.gmail.com>
Date: Sat, 17 May 2008 13:31:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "=?ISO-8859-1?Q?Albrecht_Dre=DF?=" <albrecht.dress@arcor.de>
Subject: Re: MTD on Freescale 5200B - supported?
In-Reply-To: <1211044665.4363.0@antares.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1211044665.4363.0@antares.localdomain>
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

On Sat, May 17, 2008 at 11:17 AM, Albrecht Dre=DF <albrecht.dress@arcor.de>=
 wrote:
> Hi all,
>
>
>
> the subject says it all - does the Freescale 5200B (and the 5200 Lite boa=
rd)
> support MTD for NAND flash chips (not cf cards connected to the ATA bus)?

The MPC5200 does not directly support NAND memory, but you should be
able to interface it to the local bus interface.  This is a useful
whitepaper:

http://www.freescale.com/files/32bit/doc/white_paper/NANDFLASHWP.pdf?fpsp=
=3D1&WT_TYPE=3DWhite%20Papers&WT_VENDOR=3DFREESCALE&WT_FILE_FORMAT=3Dpdf&WT=
_ASSET=3DDocumentation

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
