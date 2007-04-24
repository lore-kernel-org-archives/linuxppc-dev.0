Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 143BADDF54
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 03:43:27 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so189235ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 10:43:26 -0700 (PDT)
Message-ID: <528646bc0704241043u5d0c397cnee16a343b90fdf09@mail.gmail.com>
Date: Tue, 24 Apr 2007 11:43:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mohammad Sadegh Sadri" <mamsadegh@hotmail.com>
Subject: Re: 2.6 Kernel ,
	Xilinx Virtex and PPC 405 On chip memory controllers ( DSOCM and
	ISOCM )
In-Reply-To: <BAY115-W14E65268F6A301B98090EEB24A0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY115-W14E65268F6A301B98090EEB24A0@phx.gbl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/24/07, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:
>
> Then in mailing list I saw some where that AVNET mini-modules are using a version of FX12 FPGA which has problem with PPC caches and as the solution the caches should be off.
>
> Does the kernel always turns on the caches? Or If I choose in the base system builder to not to use caches, the kernel will not use them?

I'm pretty sure that specific issue was due to a certain version of
silicon.  You'll need to check the Xilinx errata sheets.

>
> Any special config parameter for this in xparameters.h?

No.  You need to hack the startup code to turn off caches.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
