Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pb0-f42.google.com (mail-pb0-f42.google.com
 [209.85.160.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C05F6B701F
 for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2012 01:50:58 +1000 (EST)
Received: by pbbrp12 with SMTP id rp12so3872898pbb.15
 for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2012 08:50:56 -0700 (PDT)
Date: Sat, 12 May 2012 08:50:53 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Rupjyoti Sarmah <rsarmah@amcc.com>
Subject: Re: [PATCH v16 01/10]USB/ppc4xx: Add Synopsys DWC OTG Register
 definitions
Message-ID: <20120512155053.GB6023@kroah.com>
References: <201205031223.q43CN3LN022598@amcc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201205031223.q43CN3LN022598@amcc.com>
Cc: linuxppc-dev@ozlabs.org, rsarmah@apm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 03, 2012 at 05:53:03PM +0530, Rupjyoti Sarmah wrote:
> 
> Add Synopsys Design Ware core register definitions.
> 
> Signed-off-by: Rupjyoti Sarmah <rsarmah@apm.com>
> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> ---
>  drivers/usb/dwc/regs.h | 1326 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 1326 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/dwc/regs.h

Why are you not cc: the linux-usb mailing list, and the proper
maintainers, for this patchset?

I'm guessing you aren't wanting to get these applied :)

greg k-h
