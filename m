To: Lokesh Kumar <kumar.lokesh@wrx-us.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cramfs mpc8xx 2.4.18 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 13 Feb 2004 13:32:34 EST."
             <294FD9D3403A0340BDAC38E48DCEFFDCA729@RES-EXCH>
Date: Fri, 13 Feb 2004 20:59:32 +0100
Message-Id: <20040213195937.13667C1098@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <294FD9D3403A0340BDAC38E48DCEFFDCA729@RES-EXCH> you wrote:
>
> I have a custom board running 2.4.18 with initrd. Now, I want to make cramfs
> as root filesystem. When I built cramfs support in the kernel and gave it
> root=/dev/mtdblock1 (where my cramfs in correct endian order is stored on
> flash) rootfstype=cramfs, the kernel hangs. MTD support is built in the
> kernel. If I build cramfs as module, then boot my kernel with initrd (ext2)
> and then mount it (on say /mnt), I can read cramfs correctly.

Where does the kernel hang? Which exact boot messages are printed?

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Some people march to the beat of a different drummer. And some people
tango!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
