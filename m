Return-Path: <Tom.Ziomek@motorola.com>
Received: from motgate7.mot.com (motgate7.mot.com [129.188.136.7])
	by ozlabs.org (Postfix) with ESMTP id 4DE4467CCF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 05:38:09 +1000 (EST)
Received: from az33exr02.mot.com ([10.64.251.232])
	by motgate7.mot.com (8.12.11/Motorola) with ESMTP id k7OJc6nY000304
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 12:38:07 -0700 (MST)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by az33exr02.mot.com (8.13.1/8.13.0) with ESMTP id k7OJc5As008201
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 14:38:06 -0500 (CDT)
Date: Thu, 24 Aug 2006 14:38:04 -0500 (Central Daylight Time)
From: T Ziomek <ctz001@email.mot.com>
To: Wade Maxfield <wmaxfield@gmail.com>
Subject: Re: MontaVista 2.6 Kernel support for Xilinx ML40x
In-Reply-To: <45a1b53e0608241057j4ebe519drd1e431a2275ccdde@mail.gmail.com>
Message-ID: <Pine.WNT.4.61.0608241432311.200@holyoke.labs.mot.com>
References: <DADA32856852FC458E0F96B664A6F55E011E2423@kom-mailsrv1.kontron-modular.com>
	<45a1b53e0608240836l52ed51b5u309e31dd8486cc5b@mail.gmail.com>
	<44EDD947.3000105@xilinx.com>
	<45a1b53e0608241057j4ebe519drd1e431a2275ccdde@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: ppc <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[top-posting fixed  :-) ]


On Thu, 24 Aug 2006, Wade Maxfield wrote:
>
> On 8/24/06, Peter Ryser <peter.ryser@xilinx.com> wrote:
>> 
>>  Wade,
>> 
>> are you sure that you did not build your hardware with evaluation cores of
>> the licenses? If you are using the evaluation licenses the hardware (FPGA
>> design) will stop working after a certain amount of time and you will see a
>> lock-up.
>
> Good question.  How long before lockup?  The only core that should be
> licensed is the ethernet, and I know it was sysgened on a system with a
> license.  This is the Xilinx reference design for the ml403 board.

When we were using the eval version of Xilinx's 10/100 EMAC it would time-
out after 8 hours (and the kernel would panic since our root fs was NFS-
mounted).

If your only [to-be-]licensed core is Ethernet, then I take it you're using
the UARTLite, or a non-Xilinx UART?  We used Xilinx's 16550-compatible UART,
which is licensed, but I never ran with the eval version of that IP block
and so have no idea how long it will function before shutting down.

Tom
-- 
A: Because it breaks the logical        |
     flow of the message.                |   Email to user 'CTZ001'
                                         |             at 'email.mot.com'
Q: Why is top posting frowned upon?     |
