Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56BC11A07D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 17:48:10 +1100 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6EF3D1400BE
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2014 17:48:08 +1100 (EST)
Message-ID: <1412746096.30859.229.camel@pasglop>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Dave Airlie <airlied@linux.ie>,
 Takashi Iwai <tiwai@suse.de>
Date: Wed, 08 Oct 2014 16:28:16 +1100
In-Reply-To: <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
References: <1412656696.30859.122.camel@pasglop>
 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linux PCI <linux-pci@vger.kernel.org>,
 Anton Blanchard <anton@au1.ibm.com>, Yijing Wang <wangyijing@huawei.com>,
 Brian King <brking@linux.vnet.ibm.com>, Alex Deucher <alexdeucher@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-10-07 at 19:47 -0400, Alex Deucher wrote:
> > This moves the setting of the quirk flag to the audio driver.
> >
> > While recent ASICs have that problem fixed, they don't seem to
> > be listed in the PCI IDs of the current driver, so let's quirk all
> > the ATI HDMI for now. The consequences are nil on x86 anyway.
> >
> > Signed-off-by: Alex Deucher <alexdeucher@gmail.com>
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > CC: <stable@vger.kernel.org>
> 
> Further discussion with the hw teams have revealed that this is still
> an issue on newer asics so I think your original patch is correct
> after all.  Just disable 64 bit MSIs on all AMD audio PCI ids.

Allright, I won't resend the whole series, I can just pickup my previous
patch. Takashi, Bjorn, Dave, this series covers your 3 areas of
maintainership, how do you want to proceed ? I'm happy to merge the
whole lot via powerpc ASAP (since it's all CC'ed stable) if you guys
send me the appropriate acks, otherwise, let me know.

Cheers,
Ben.
