Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 3929CDDECD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Oct 2007 00:45:59 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so702807wag
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 07:45:58 -0700 (PDT)
Message-ID: <fa686aa40710250745i57f2a88sbc08478738ee382a@mail.gmail.com>
Date: Thu, 25 Oct 2007 08:45:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: PCI on Lite5200/Icecube, known issues?
In-Reply-To: <4720A628.8010108@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4720A628.8010108@grandegger.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/25/07, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Hello,
>
> The access to PCI memory space does not to work (I allways read 0xff) on
> my Icecube-Eval-Board. Are there any known issues/bugs with using the
> PCI on the Lite5200/Icecube board with 2.6.23? Has it been tested? I
> realized, that CONFIG_PCI is not set in the default configuration.

arch/ppc or arch/powerpc?

I'm not a PCI expert, but I just fired up my Lite5200 with a couple of
eth adapters plugged in and the devices are usable.  This is a
2.6.24-rc1 arch/powerpc kernel.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
