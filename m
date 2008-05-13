Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 87C72DDF61
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 May 2008 23:54:50 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so746437anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 May 2008 06:54:48 -0700 (PDT)
Message-ID: <fa686aa40805130654x114b4ec8p57622d0632a31692@mail.gmail.com>
Date: Tue, 13 May 2008 07:54:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: mojtaba <kernelppc@gmail.com>
Subject: Re: Linux on Ml410
In-Reply-To: <016601c8b4ed$a56e57a0$f04b06e0$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <016601c8b4ed$a56e57a0$f04b06e0$@com>
Cc: John Linn <John.Linn@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, May 13, 2008 at 5:36 AM, mojtaba <kernelppc@gmail.com> wrote:
> Dear all,
>
>  I am trying to run linux 1.6.25 on ML410 board. When the system boot I
>  receive this error:
>
>  loaded at:     00400000 004CD19C
>  board data at: 004CB120 004CB19C
>  relocated to:  00404050 004040CC
>  zimage at:     00404E3C 004CA0D1
>  avail ram:     004CE000 10000000
>
>  Linux/PPC load: console=ttyS0,115200 root=/dev/xsa2
>  Uncompressing Linux...inflate returned FFFFFFFD
>  exit

Not good.  If you get an error like this during decompression then you
probably have some sort of memory error.  Are you using a reference
design, or have you built a new design?  Have you tested your

It could also be a corrupt kernel image.  How did you build it?  How
large is the image?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
