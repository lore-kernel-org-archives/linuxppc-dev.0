Message-ID: <3AA8CDBE.F0EA84C0@iiic.ethz.ch>
Date: Fri, 09 Mar 2001 13:34:06 +0100
From: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Henry Worth <haworth@ncal.verio.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Pismo Aty128fb problem in 2.4.3-pre*?
References: <3AA41B77.73470672@ncal.verio.com> <3AA5113F.A0B78521@ncal.verio.com> <3AA621D3.755358F7@iiic.ethz.ch> <3AA8480F.F5E09C8E@ncal.verio.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Henry Worth wrote:

> Is there any hope that the ATI 128 DRI stuff is going to get reenabled soon?

Yes, the branch of the DRI CVS dedicated to adding PCI GART support (which is
needed for us since we don't have AGP GART support yet) is basically done and
its merge into the trunk is imminent. Unfortunately, it doesn't work right
now, but there is a freeze tag which might work.


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
