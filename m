Message-ID: <3DDDE525.7050309@attbi.com>
Date: Fri, 22 Nov 2002 00:04:53 -0800
From: Amit Chaudhary <amit_ch@attbi.com>
MIME-Version: 1.0
To: GOTZON ASTONDOA <gastondoa@fagorautomation.es>
Cc: bgat@billgatliff.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Fast shutdown
References: <CA78D1B723D8D411AF0300508BDCF74FF0C566@NTCORREO> <20021115151001.I5906@saturn.billgatliff.com>
In-Reply-To: <CA78D1B723D8D411AF0300508BDCF74FF0C566@NTCORREO>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


William A. Gatliff wrote:

> On Tue, Nov 12, 2002 at 04:04:39PM +0100, GOTZON ASTONDOA wrote:
> >interrupt to the PowerPC.We have more or less 8 mSeg to close all the
> Linux
> >system (it has hard disk, ethernet, ftp and our own application).
> >
> >	Can somebody tell me any idea to close the Linux system in the
> >fastest way? We are thinking in capture the interrupt signal, but, is it
> >enough fast?
>
>
>
> You could have an interrupt handler watching the signal from the 68k,
> and sending a message via named pipe (perhaps) to a userspace program.
> The userspace program would signal all your other programs, sync(),
> then wait for powerdown.

Another option is mount the main fs as readonly, put in a robust
recovery for any config data fs and use something equivalent of a reboot -f.

Amit


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
