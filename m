Date: Thu, 4 Oct 2001 08:34:03 -0700
From: Mark Charlebois <mcharleb@qualcomm.com>
To: Kapil Konde <kapilkk@yahoo.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Loading kernel on ppcboot
Message-ID: <20011004083403.A21516@qualcomm.com>
References: <GDEHIPAFEMJDKNFDCIEBMEJACCAA.kapilkk@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <GDEHIPAFEMJDKNFDCIEBMEJACCAA.kapilkk@yahoo.com>; from kapilkk@yahoo.com on Thu, Oct 04, 2001 at 05:35:17PM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Have you copied the bd_t structure from ppcboot to linux? I had a
similar problem before I did this.

See the message from David Chiu on the linuxppc-embedded list from Wed,
April 11, 2001.

http://lists.linuxppc.org/linuxppc-embedded/200104/msg00084.html

Regards,

Mark


On Thu, 04 Oct 2001, Kapil Konde wrote:

>
> Hi all,
> 	I am trying to load kernel using ppcboot. After I load kernel using tftp
> and give bootm command I get following response.
>
> ....
> ....
>    Data Size:    574121 Bytes = 560 kB = 0 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Current stack ends at 0x00FBF7F0 => set upper limit to 0x00800000
> ## cmdline at 0x007FFF00 ... 0x007FFF00
> No initrd
> ## Transferring control to Linux (at address 00000000) ...
>
>
> 	And nothing happens after this. Can somebody please explain.
>
>
> Thanks and regards,
> Kapilk.
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
