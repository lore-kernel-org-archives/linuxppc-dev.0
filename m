Message-ID: <3AA621D3.755358F7@iiic.ethz.ch>
Date: Wed, 07 Mar 2001 12:56:03 +0100
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Henry Worth <haworth@ncal.verio.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Pismo Aty128fb problem in 2.4.3-pre*?
References: <3AA41B77.73470672@ncal.verio.com> <3AA5113F.A0B78521@ncal.verio.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Henry Worth wrote:
>
> Narrowed down the problem a bit more. Specifying
> "video=aty128fb:mode:17" works; also without the mode.
> But, adding a depth parm (8,16,24, or 32) causes the
> fb init failure. It defaults to 8 and fbset works for
> 8,15,16,32 but 24 causes a blurry image.

The last is - *tadda* - an endianness error. aty128fb incorrectly enables byte
swapping for 24 bit, which can easily be fixed; look for CONFIG_CNTL .


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
