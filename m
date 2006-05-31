Return-Path: <Chetan.S.Anantharaman@motorola.com>
Received: from motgate4.mot.com (motgate4.mot.com [144.189.100.102])
	by ozlabs.org (Postfix) with ESMTP id BF3CC679E1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Jun 2006 07:47:34 +1000 (EST)
Received: from az33exr03.mot.com (az33exr03.mot.com [10.64.251.233])
	by motgate4.mot.com (8.12.11/Motgate4) with ESMTP id k4VLlWQ0001363
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 14:47:32 -0700 (MST)
Received: from de01exm68.ds.mot.com (de01exm68.am.mot.com [10.176.8.24])
	by az33exr03.mot.com (8.13.1/8.13.0) with ESMTP id k4VLlVGx004774
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 16:47:32 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux 2.4 Kernel on Xilinx Virtex4 FX100's PPC
Date: Wed, 31 May 2006 17:47:31 -0400
Message-ID: <EDF27F298D4B03498AE0C249A941DFF803D6E8@de01exm68.ds.mot.com>
In-Reply-To: <528646bc0605311235n171f889g135e074685b578bc@mail.gmail.com>
From: "Anantharaman Chetan-W16155" <Chetan.S.Anantharaman@motorola.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
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

Was the port done on a FX100 FPGA? Also, what PVR number does the PPC405
indicate?
Thanks,
Chetan

-----Original Message-----
From: glikely@gmail.com [mailto:glikely@gmail.com] On Behalf Of Grant
Likely
Sent: Wednesday, May 31, 2006 2:35 PM
To: Anantharaman Chetan-W16155
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux 2.4 Kernel on Xilinx Virtex4 FX100's PPC

On 5/31/06, Anantharaman Chetan-W16155
<Chetan.S.Anantharaman@motorola.com> wrote:
>
> Has anyone successfully ported a Linux 2.4 Kernel on a Xilinx Virtex-4
FX
> series FPGA's, PPC405 processor?

Linux on the V4-FX is well supported.  Xilinx has an app node
describing how to modify the linuxppc-2.4 tree to work on the V4-FX.
You can find out how to get the tree here:

http://www.penguinppc.org/kernel/

I've got both 2.4 & 2.6 happily running on my ML403 board here.

Cheers,
g.

--=20
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
