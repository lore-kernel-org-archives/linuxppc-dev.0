Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id AAF6E67B18
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Jun 2006 08:33:48 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id l23so258479nfc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 15:33:46 -0700 (PDT)
Message-ID: <528646bc0605311533u147797fdhd5178420bc2f0b4b@mail.gmail.com>
Date: Wed, 31 May 2006 16:33:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Anantharaman Chetan-W16155" <Chetan.S.Anantharaman@motorola.com>
Subject: Re: Linux 2.4 Kernel on Xilinx Virtex4 FX100's PPC
In-Reply-To: <EDF27F298D4B03498AE0C249A941DFF803D6E8@de01exm68.ds.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0605311235n171f889g135e074685b578bc@mail.gmail.com>
	<EDF27F298D4B03498AE0C249A941DFF803D6E8@de01exm68.ds.mot.com>
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

On 5/31/06, Anantharaman Chetan-W16155
<Chetan.S.Anantharaman@motorola.com> wrote:
> Was the port done on a FX100 FPGA?

No; but AFAIK, the ppc hardcore is identical for all FX parts.  The
FX100 shoudn't be a problem.

> Also, what PVR number does the PPC405 indicate?

Core#0>rd pvr
pvr: 0x20011430  536941616
