Message-Id: <5.1.0.14.2.20021010062618.0221d928@falcon.si.com>
Date: Thu, 10 Oct 2002 06:29:04 -0400
To: <linuxppc-embedded@lists.linuxppc.org>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: /dev/console and mknod question
In-Reply-To: <0B0A39652BB0D411BCCF00508B9512EC08AEB466@tx14exm05.ftw.mot
 .com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


mknod is a generic unix command, used to make device controlling entries
(nodes) in the /dev tree.

gvb


At 10:21 PM 10/9/2002 -0500, Yu Bo-BOYU1 wrote:

>Finally I got the linux work on my custom board. At first I encountered
>"unable to open an initial console" problem. I created /dev/console then it
>worked.
>
>But I am still wondering how this /dev/console works ? Why mknod (which I
>think
>is a native intel platform command) can create a device that cross platform
>powerpc linux
>can understand ?
>
>Thanks.
>
>Bo Yu
>Motorola, GTSS
>1-817-245-6725
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
