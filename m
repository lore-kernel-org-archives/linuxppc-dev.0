Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pb0-f42.google.com (mail-pb0-f42.google.com
 [209.85.160.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 77C45B700F
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2012 02:03:48 +1000 (EST)
Received: by pbcun1 with SMTP id un1so5352620pbc.15
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2012 09:03:46 -0700 (PDT)
Date: Mon, 16 Apr 2012 09:03:42 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Anthony Foiani <tkil@scrye.com>
Subject: Re: PPC / USB: kernel hangs in warm boot on 8513 in fsl-ehci
Message-ID: <20120416160342.GC23627@kroah.com>
References: <gsjg4i8sh.fsf@dworkin.scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <gsjg4i8sh.fsf@dworkin.scrye.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 15, 2012 at 10:45:50PM -0600, Anthony Foiani wrote:
> I could try the latest kernels, but due to our vendor not upstreaming
> their patches, there could be some pain in that transition.

I would push back on that vendor, as this is their support issue, not
ours :)

Seriously, that's the best way forward, they are the ones providing your
kernel, so they need to handle this, and they can do so better than we
can, right?

good luck,

greg k-h
