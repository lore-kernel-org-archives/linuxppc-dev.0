Message-ID: <38714235.9CB27C5B@ctam.com.au>
Date: Tue, 04 Jan 2000 11:43:33 +1100
From: Brendan J Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: dony <dony.he@huawei.com.cn>
CC: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: decompress_kernel() questions......
References: <387553E8.86C9F334@huawei.com.cn>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dony wrote:

> Now the bootloader can work. But when it enters into
> decompress_kernel( )£¬It shows a message " bad gzipped data " and
> exit. I trace the misc.c and find this message is appeared in
> gunzip(). I think it cannot locate the offset of the zipped kernel
> image file. Do you have any experience?
> Thanks.

Yep.  I had the same experience.
It means that the kernel image isn't loaded into flash or it is loaded
in the wrong location.

Can you post the output of your terminal output and of "powerpc-linux
--headers zImage".

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
