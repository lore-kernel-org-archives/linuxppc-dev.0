Message-Id: <4.3.2.20001011072641.00b74a60@falcon.si.com>
Date: Wed, 11 Oct 2000 07:29:22 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: exchanges file in minicom
In-Reply-To: <39E3915B.528A90FF@emc.com>
References: <Pine.HPX.4.10.10010102202210.16113-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You can use uuencode to convert binary to an ASCII encoding, transfer
the (now ASCII) file via cat (or use the minicom capture feature), and
then use uudecode to convert the file back into binary.  You can use
tar to bundle files together and gzip to make them smaller before you
uuencode them (making them bigger again :-).

This is technically inferior to the zmodem approach, but all the tools
should already be on your systems.

gvb


At 05:59 PM 10/10/00 -0400, Zhaobin Zhu wrote:

>Hi,
>
>I boot linux over IDE disk.
>The only connection between host and target is RS232 which is used
>to download and as console(minicom).
>
>After kernel is running on target, how can I send/receive files between
>host(minicom/linux) and target ?
>
>For ascii file, I can use "cat  < /dev/ttyS0" on target, and
>"ascii-xfr .." on host. How about Binary files ?
>
>Thanks,
>--
>  Zhaobin Zhu
>  zzhu@emc.com
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
