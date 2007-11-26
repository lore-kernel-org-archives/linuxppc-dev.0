Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by ozlabs.org (Postfix) with ESMTP id D7407DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 03:40:37 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so537055wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 08:40:36 -0800 (PST)
Message-ID: <fa686aa40711260830y46aeb64cy8b662cad7196af8d@mail.gmail.com>
Date: Mon, 26 Nov 2007 09:30:35 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
Subject: Re: Xilinx devicetrees
In-Reply-To: <EDAE140DF1B2FC42B5867C22CA0B333F0A58E4@XMBIL132.northgrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47480CF0.7090105@dlasys.net>
	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>
	<47493D4F.4070605@dlasys.net>
	<fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com>
	<4749FD5E.7000408@dlasys.net>
	<20071125235855.95B9999804D@mail138-cpk.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A58E4@XMBIL132.northgrum.com>
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/26/07, Koss, Mike (Mission Systems) <mike.koss@ngc.com> wrote:
> DL>    And once again a plea to ALWAYS make version/capabilities registers
> DL> atleast an optional part of every design.
> DL>    Embeddeding a device tree into a design might be fairly expensive. a
> DL> pair of read only 32 bit registers is damn near free - basically the
> DL> FPGA equivalent of atmost 64 diodes or resistors.
>
> SN> Actually, device trees actually seem to be cheaper (in the whole system
> sense) than such registers.  Unless there is something I don't understand?
>
> The issue here is that the hardware changed and the driver doesn't support
> it. I think this would be fixed by having information passed to the driver
> in the platform_device struct to specify information, since its not able to
> be discerned by the physical hardware information: version registers, etc.

This is exactly the information that should be encoded in the
'compatible' property of the device tree.  (instead of platform_data;
platform_data is no longer required with the of_platform bus binding)

*If* edk is generating our device tree(s) for us, *then* version
registers are not needed by Linux.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
