To: Lokesh Kumar <kumar.lokesh@wrx-us.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cramfs mpc8xx 2.4.18 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 27 Feb 2004 19:03:44 EST."
             <294FD9D3403A0340BDAC38E48DCEFFDCA751@RES-EXCH>
Date: Sun, 29 Feb 2004 17:31:51 +0100
Message-Id: <20040229163156.68274C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <294FD9D3403A0340BDAC38E48DCEFFDCA751@RES-EXCH> you wrote:
>
> Kernel command line: root=/dev/mtdblock1 rootfstype=cramfs console=ttyS0,9600
...
> ok
> mtdblock_open
> mtdblock: read on "cramfs" at 0x0, size 0x1000
> mtdblock: read on "cramfs" at 0x1000, size 0x1000
> mtdblock: read on "cramfs" at 0x2000, size 0x1000
> mtdblock: read on "cramfs" at 0x3000, size 0x1000
> mtdblock_release
>
> And after this, I do not get the prompt back, and the target hangs. My
> cramfs rootfilesystem has
>
> /bin, /dev, /etc, /sbin, /lib and /usr/sbin

Are you sure? Can you mount the same  filesystem  when  running  with
root filesystem mounted over NFS or from a ramdisk?

Did you remember  that  you  might  need  the  "-r"  option  (reverse
endian-ness of filesystem) when creating the filesystem?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I distrust all systematisers, and avoid them. The will  to  a  system
shows a lack of honesty.
- Friedrich Wilhelm Nietzsche _Götzen-Dämmerung [The Twilight of  the
Idols]_ ``Maxims and Missiles'' no. 26

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
