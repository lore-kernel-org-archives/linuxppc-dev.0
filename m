Return-Path: <peter.ryser@xilinx.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8DB0367A70
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Jun 2006 03:23:31 +1000 (EST)
Message-ID: <447F1D0E.2010002@xilinx.com>
Date: Thu, 01 Jun 2006 09:59:58 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: Anantharaman Chetan-W16155 <Chetan.S.Anantharaman@motorola.com>
Subject: Re: Linux 2.4 Kernel on Xilinx Virtex4 FX100's PPC
References: <EDF27F298D4B03498AE0C249A941DFF803D6E8@de01exm68.ds.mot.com>
In-Reply-To: <EDF27F298D4B03498AE0C249A941DFF803D6E8@de01exm68.ds.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

We have Linux up and running on the Virtex-4 FX100. The PVR for the 
PPC405 in all FX100 is 0x20011470.

- Peter


Anantharaman Chetan-W16155 wrote:

>Was the port done on a FX100 FPGA? Also, what PVR number does the PPC405
>indicate?
>Thanks,
>Chetan
>
>-----Original Message-----
>From: glikely@gmail.com [mailto:glikely@gmail.com] On Behalf Of Grant
>Likely
>Sent: Wednesday, May 31, 2006 2:35 PM
>To: Anantharaman Chetan-W16155
>Cc: linuxppc-embedded@ozlabs.org
>Subject: Re: Linux 2.4 Kernel on Xilinx Virtex4 FX100's PPC
>
>On 5/31/06, Anantharaman Chetan-W16155
><Chetan.S.Anantharaman@motorola.com> wrote:
>  
>
>>Has anyone successfully ported a Linux 2.4 Kernel on a Xilinx Virtex-4
>>    
>>
>FX
>  
>
>>series FPGA's, PPC405 processor?
>>    
>>
>
>Linux on the V4-FX is well supported.  Xilinx has an app node
>describing how to modify the linuxppc-2.4 tree to work on the V4-FX.
>You can find out how to get the tree here:
>
>http://www.penguinppc.org/kernel/
>I've got both 2.4 & 2.6 happily running on my ML403 board here.
>
>Cheers,
>g.
>
>  
>
