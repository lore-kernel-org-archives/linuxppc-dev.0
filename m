Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 134CD67B17
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Jun 2006 05:35:23 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id k26so189859nfc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 12:35:21 -0700 (PDT)
Message-ID: <528646bc0605311235n171f889g135e074685b578bc@mail.gmail.com>
Date: Wed, 31 May 2006 13:35:21 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Anantharaman Chetan-W16155" <Chetan.S.Anantharaman@motorola.com>
Subject: Re: Linux 2.4 Kernel on Xilinx Virtex4 FX100's PPC
In-Reply-To: <EDF27F298D4B03498AE0C249A941DFF803D6E6@de01exm68.ds.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <EDF27F298D4B03498AE0C249A941DFF803D6E6@de01exm68.ds.mot.com>
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
>
> Has anyone successfully ported a Linux 2.4 Kernel on a Xilinx Virtex-4 FX
> series FPGA's, PPC405 processor?

Linux on the V4-FX is well supported.  Xilinx has an app node
describing how to modify the linuxppc-2.4 tree to work on the V4-FX.
You can find out how to get the tree here:

http://www.penguinppc.org/kernel/

I've got both 2.4 & 2.6 happily running on my ML403 board here.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
