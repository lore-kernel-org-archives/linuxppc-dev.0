Message-ID: <3D2A10DE.4090607@attbi.com>
Date: Mon, 08 Jul 2002 15:23:26 -0700
From: Henry Worth <haworth15@attbi.com>
MIME-Version: 1.0
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XV lockups with SMP 2.4.19-rc1-ben0
References: <3D2A09D1.3080700@attbi.com> <1026165472.1263.654.camel@tibook>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:

>
>This is very likely related to DRI. Disable it or start a second server
>with it disabled for Xv or try
>http://www.penguinppc.org/~daenzer/XFree86-4.2/patches/r128-optiondmaforxv.diff
>
>
Thanks for the quick response, disabling DRI works. I'll have to try
updating X, is that patch in the current CVS snapshot?

But now I get to drive myself nuts as to why it did work repeatedly with
Saturday's rsync. The X configuration hadn't changed and I'm pretty sure
the DRM modules were getting loaded... oh well.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
