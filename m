Message-id: <fc.000086e900b6e3523b9aca00400dc471.b6e364@softarc.com>
Date: Thu, 21 Jan 1999 09:57:48 -0500
Subject: Re: Create kernel to boot with BootX
To: mrasche@datan.de
Cc: linuxppc-dev@lists.linuxppc.org
From: baron@softarc.com (Chris D. Baron)
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


mrasche@datan.de writes:
>
>Hello,
>
>we have the LinuxPPC Release 4, if create a kernel (2.1.24) from the
>src, can't boot
>with this kernel from bootX.
>I can boot with the kernel 2.1.124 (from the ftp-side). But on the CD is
>
>only the src from kernel 2.1.24
>
>Mac G3 with 300MHZ and 6GByt IDE with MacOs 8.5.

You need a kernel  >= 2.1.125( although it looks like you are running fine with
2.1.124) to work with bootX. See http://calvaweb.calvacom.fr/bh40/ for
additional details.

Regards,
Chris Baron
SoftArc Inc. 
>
>
>
>


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
