Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id 365A167A70
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Jun 2006 03:11:03 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id l36so606827nfa
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 01 Jun 2006 10:11:01 -0700 (PDT)
Message-ID: <528646bc0606011008o35096b43p42cc6aa9c0002f8c@mail.gmail.com>
Date: Thu, 1 Jun 2006 11:08:43 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Peter Ryser" <peter.ryser@xilinx.com>
Subject: Re: Linux 2.4 Kernel on Xilinx Virtex4 FX100's PPC
In-Reply-To: <447F1E48.10808@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <EDF27F298D4B03498AE0C249A941DFF803D6E6@de01exm68.ds.mot.com>
	<447E1725.4010908@nicta.com.au> <447F1E48.10808@xilinx.com>
Cc: Anantharaman Chetan-W16155 <Chetan.S.Anantharaman@motorola.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/1/06, Peter Ryser <peter.ryser@xilinx.com> wrote:
> There are some silicon issues on the PPC405 in V4 with PVR 0x20011430
> which are documented in Xilinx solution record 20658. All these issues
> are fixed in silicon where the PPC405 has a PVR of 0x20011470.
>
> Said that it's not true that the caches cannot be used in silicon with
> PVR 0x20011430. The problem is a corner case which does not show in
> typical designs.

If I understand correctly, the cache issue only shows up with RAM
attached to the OPB (instead of PLB).  Is that correct?

Cheers,
g.
