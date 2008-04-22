Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by ozlabs.org (Postfix) with ESMTP id BE801DE0AB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 06:55:34 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1949005wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Apr 2008 13:55:33 -0700 (PDT)
Message-ID: <fa686aa40804221355s11f8fd6em3f2075bbb2073c8@mail.gmail.com>
Date: Tue, 22 Apr 2008 14:55:32 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Aaron Sells" <aaron.sells@zin-tech.com>
Subject: Re: SecretLab 2.6.24 with USB
In-Reply-To: <480E4EBD.3010202@zin-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <800687fe0804141927y1f6ea75cv7ad0ba68b4fa637a@mail.gmail.com>
	<fa686aa40804211109g2f7f45d0gf836be46e2c1a40b@mail.gmail.com>
	<16825460.post@talk.nabble.com>
	<fa686aa40804221309g7d0749e8qc329ad72389f0138@mail.gmail.com>
	<480E4EBD.3010202@zin-tech.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2008 at 2:46 PM, Aaron Sells <aaron.sells@zin-tech.com> wrote:
> Grant Likely wrote:
>
> > 2. Make sure a platform device for the usb controller is getting
> > registered with the kernel.
> >
>
>  Correct me if I'm wrong, but it does not look like my Cypress CY7C6300 USB
> host controller is getting registered with the kernel.  Any ideas?

Compare arch/ppc/syslib/virtex_devices.c with the one in my git tree.
Add the relevant missing bits.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
