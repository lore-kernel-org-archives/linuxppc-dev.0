Message-Id: <200109061544.LAA11977@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MVME5100 and bugboot fails
Date: Thu, 6 Sep 2001 11:36:39 -0400
References: <85256ABF.00549667.00@pine.cspi.com>
In-Reply-To: <85256ABF.00549667.00@pine.cspi.com>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I tried that and I was unable to relocate just the initrd. Right now, I just
tested to see:
if  ((zImage_start >= 0xf0000000) || (zImage_start <= 0x00800000))

That seems to work for now, but I'll take a peek at the gemeni and see how
they do it.


On Thursday 06 September 2001 11:23 am, you wrote:
> On Thu, Sep 06, 2001 at 10:55:46AM -0400, Brian Waite wrote:
> > I am playing with the MVME5100 and I am having a bit of trouble with
>
> booting
>
> > using bugboot and an initrd. I get a message at bootup saying initrd > 16
>
> MB
>
> > and then as it is booting it gets an oops in mem_init.
>
> [snip]
>
> > My question is is the failure due to the bootloader not relocating the
>
> initrd
>
> > or is it that ClearPageReserved() is being called when the initrd is in
> > FLASH? Any ideas?
>
> Right now, we only see if we need to relocate the initrd if we need to
> relocate
> the kernel.  I'll go and fix this (I think gemini has the right idea).

--
Thanks
Brian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
