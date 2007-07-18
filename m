Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by ozlabs.org (Postfix) with ESMTP id 96DF5DE2F9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jul 2007 12:18:34 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so38908nzf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jul 2007 19:18:33 -0700 (PDT)
Message-ID: <fa686aa40707171918g2ff34d7kef320c6d409ca676@mail.gmail.com>
Date: Tue, 17 Jul 2007 20:18:32 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robertson, Joseph M." <joseph.robertson@sanmina-sci.com>
Subject: Re: Cypress c67x00 Support?
In-Reply-To: <939D37AEB47F1F49B88FAB6599B6023501A1721C@hsv1dafpew02.das.gov.sanm.corp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <939D37AEB47F1F49B88FAB6599B6023501A1721C@hsv1dafpew02.das.gov.sanm.corp>
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

On 7/17/07, Robertson, Joseph M. <joseph.robertson@sanmina-sci.com> wrote:
>
>
>
> Hi,
>
>  I have some questions about the Cypress c67x00 code that was posted a few
> days ago.
>  I got the many patches from the git (thanks Grant!), but I am wondering,
>
>  How did you guys fix up the Kconfigs to work with the Xilinx Virtex-4 fpga?

You need to register the device on the platform bus.  Look at
arch/ppc/syslib/virtex_devices.c and
arch/ppc/platforms/4xx/xparameters/xparameters.h.  You need to fixup
your xparameters file to match up with the c67x00 registration in
virtex_devices.c. (hint: look at the XPAR_C67x00_USB macro)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
