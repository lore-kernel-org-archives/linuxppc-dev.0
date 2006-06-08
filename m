Return-Path: <netstv@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 2FE8567BCF
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 04:39:28 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id m51so681060pye
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 08 Jun 2006 11:39:26 -0700 (PDT)
Message-ID: <b4b98b690606081139u516c0fc0p415fd0452c3f6d0c@mail.gmail.com>
Date: Thu, 8 Jun 2006 11:39:25 -0700
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: "Chris Dumoulin" <cdumoulin@ics-ltd.com>
Subject: Re: VFS: Cannot open root device ...
In-Reply-To: <44885C45.7020009@ics-ltd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <44885C45.7020009@ics-ltd.com>
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

On 6/8/06, Chris Dumoulin <cdumoulin@ics-ltd.com> wrote:
> I'm trying to port a 2.6 kernel to a V2Pro-based board that I've got. I
> get the following output when trying to boot:
>
> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem).
> VFS: Cannot open root device "<NULL>" or unknown-block(0,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)

What boot loader are you using?  In the boot loader where does it
think the root fs is located?  My guess is /dev/ram0 or something like
that?

So I'd check your ramdisk to see that it has a /dev/ram0.
Make sure you have rights to it.

-stv
>
> I'm trying to use an initrd RAMDISK, and I've made sure that RAMDISK and
> initrd support are both enabled in the kernel configuration. Any ideas
> would be appreciated.
>
> Cheers,
> Chris Dumoulin
> --
> *--Christopher Dumoulin--*
> Software Team Leader
>
> <http://ics-ltd.com/>
> <http://ics-ltd.com/>
>
> Interactive Circuits and Systems Ltd.
> 5430 Canotek Road
> Ottawa, ON
> K1J 9G2
> (613)749-9241
> 1-800-267-9794 (USA only)
>
> ------------------------------------------------------------------------
> This e-mail is private and confidential and is for the addressee only.
> If misdirected, please notify us by telephone and confirm that it has
> been deleted from your system and any hard copies destroyed. You are
> strictly prohibited from using, printing, distributing or disseminating
> it or any information contained in it save to the intended recipient.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
