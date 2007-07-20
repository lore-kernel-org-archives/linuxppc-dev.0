Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by ozlabs.org (Postfix) with ESMTP id C34FADDE23
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jul 2007 01:12:05 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so794554nzf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jul 2007 08:12:04 -0700 (PDT)
Message-ID: <fa686aa40707200812w3427c12dwd10b08c8433af2fc@mail.gmail.com>
Date: Fri, 20 Jul 2007 09:12:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: Mirek23 <miroslaw.dach@psi.ch>
Subject: Re: Interrupts on xilinx ml403
In-Reply-To: <11708607.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11708607.post@talk.nabble.com>
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

On 7/20/07, Mirek23 <miroslaw.dach@psi.ch> wrote:
> Does it mean that DIP Switches do not use INTC interrupt controller?
> How to handle the DIP Switches interrupt?
> Does the Interrupt handler routine have to acknowledge the interrupt from
> Dip Switches?

It probably means that the GPIO irq out line is not hooked up to your
INTC in the system.mhs file.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
