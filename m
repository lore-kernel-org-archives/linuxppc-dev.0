Return-Path: <glikely@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.230])
	by ozlabs.org (Postfix) with ESMTP id 153BD67B32
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 02:34:51 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 36so488828wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Aug 2006 09:34:50 -0700 (PDT)
Message-ID: <528646bc0608030934j6864669agdddbb413e6480e8f@mail.gmail.com>
Date: Thu, 3 Aug 2006 10:34:49 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Milton Miller" <miltonm@bga.com>
Subject: Re: Booting Linux Kernel without bootloader
In-Reply-To: <b4c0f7394350325fbdbfe66afb1b4ec8@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <311545913012eb141f24.1102520059.miltonm@bga.com>
	<528646bc0608030734j163acdd0gf37f19ece6f18c09@mail.gmail.com>
	<b4c0f7394350325fbdbfe66afb1b4ec8@bga.com>
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

On 8/3/06, Milton Miller <miltonm@bga.com> wrote:
> > I've got a similar situation on my Virtex-4 platform.  The FPGA takes
> > care of all device initialization.  However, the kernel is loaded of a
> > CF card via a *slow* JTAG interface.  Loading an uncompressed image is
> > more time consuming than loading a compressed image and uncompressing
> > it in software.
>
> This is often the case.  However, if its loaded via some kind of DMA
> access
> from a higher powered cpu then loading the uncompressed kernel could be
> the fastest way.  Since we don't know we can only mention things to
> consider as we state what can be done.

As alwasy; the devil is in the details.  :)

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
