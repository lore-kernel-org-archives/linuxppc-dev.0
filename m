Message-Id: <4.2.2.20000121163453.03db3200@mail.munich.netsurf.de>
Date: Fri, 21 Jan 2000 16:37:14 +0100
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: gcc 2.95/PPC bug
Cc: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <388804D3.DF16EE2F@mpifr-bonn.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 08:03 21.01.00 , Albrecht Dreﬂ wrote:

>When trying to find the cause for crashes of LAME, I think I found a
>bug in the gcc.  The code below (which is actually a simpilified excerpt
>from LAME) will NOT pass the parameter `buggy' correctly to the
>subroutine.  Changing the number/type/sorting of the parameters will,
>however, produce a working code in some cases.  Some facts about the
>system:
>
>   Machines: PowerMac 7300 (604e), LinuxPPC 2.2.11
>             PB "Lombard" (G3), LinuxPPC 2.2.12
>   gcc:      versions 2.95 and 2.95.1
>   options:  gcc -O0 -Wall gcc-2.95-ppc-bug.c -o gcc-2.95-ppc-bug
>
>Is this a known (and hopefully already fixed ;-) bug, or should it go
>directly to gcc-bugs@gcc.gnu.org?

I believe this is fixed in my current gcc-2.95.2 RPM-set available on
<ftp://devel.linuxppc.org/users/fsirl/>.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
