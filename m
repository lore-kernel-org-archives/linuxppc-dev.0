Date: Mon, 14 Oct 2002 15:26:11 -0700
From: Andrew May <acmay@acmay.homeip.net>
To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Binary Compatibility of various flavors of PPC
Message-ID: <20021014222611.GA27644@acmay.homeip.net>
References: <816F7B3D-DFAF-11D6-A599-003065BFB10E@motorola.com> <Pine.LNX.4.33.0210141629240.24959-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0210141629240.24959-100000@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Oct 14, 2002 at 04:37:49PM -0500, Bret Indrelee wrote:
>
> Float isn't important to us, we could have all float be emulated for as
> little of it we do.
>
> We need the bzImage.gz and RAM disk image have to be the same binary.
>
> The reason is simple, we don't want the customer to have the mess of
> 'which of these N firmware images do I need' when trying to upgrade. We
> want the whole line of products to use the same binary image.

Looks like you are looking at the problem wrong. Send the custumors a big
binary file with all the images and have the update program be smart about
selecting the correct images for the hardware out of the big binary.

It is more work to build the images but less work than getting one image
to work on different CPU's. You could even support x86 parts with a smart
updater.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
