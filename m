Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id 8B0BC67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 07:00:03 +1100 (EST)
To: srinivas.surabhi@wipro.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 15 Feb 2005 19:04:52 +0530."
	<EF9B29C78F41FA488927FCBC7750AF0E011DA5CB@hyd-mdp-msg.wipro.com>
Date: Tue, 15 Feb 2005 20:59:39 +0100
Sender: wd@denx.de
Message-Id: <20050215195944.CBDEFC1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mounta Vista Linux prompt on serial console 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <EF9B29C78F41FA488927FCBC7750AF0E011DA5CB@hyd-mdp-msg.wipro.com> you wrote:
> 
> My replies in blue tagged with surabhi

Don't do this. Email is a plain text medium only.

Read the netiquette, and quote properly.

> [surabhi --- start] could you please guide me how to provide a working
> file system on SDRAM before decompressing the Linux Image on SDRAM. Is
> it really related to init process failed.

It is obviously related -there was a clear  error  message  that  the
uncompressing of the cramfs filesystem failed.

> Is the below doesn't mean that the mounted one is working one ?
> "VFS: Mounted root (cramfs filesystem) readonly.
>  Mounted devfs on /dev "

No, not at all. You can for example mount an empty  filesystem  -  it
will mount perfectly fine, but it still doesn't work.


You should also read my message until the end; I asked:


>> Do not ignore this error. How big is your cramfs iage? How  much  RAM
>> do you have?
...
>> Is there any chance that you built your cramfs image on a x08 (or any
>> other little-endian) system and forgot  to  give  the  "-r"  (reverse
>> endian-ness of filesystem) option to mkcramfs??


Best regards,

Wolfgang Denk

-- 
See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Looks clean and obviously correct to me, but then _everything_ I
write always looks obviously correct to me.  - Linus Torvalds in
<Pine.LNX.4.10.10012090054360.791-100000@penguin.transmeta.com>
