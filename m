Message-ID: <3D2E1112.1080701@attbi.com>
Date: Thu, 11 Jul 2002 16:13:22 -0700
From: Henry Worth <haworth15@attbi.com>
MIME-Version: 1.0
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: XV lockups with SMP 2.4.19-rc1-ben0
References: <3D2A09D1.3080700@attbi.com> <1026165472.1263.654.camel@tibook>	 <3D2DC734.9040503@attbi.com> <1026420371.1199.2006.camel@tibook>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:

>>_Both the YDL installed 4.2 binaries and the patched 4_2-branch with DRI
>>  enabled, the kdm login window is nearly unreadable. The subwindow
>>  background has a cross-hatch, same as startup stipple, that blends with
>>  the prompt and input field. Will sometimes clearup after a few VT
>>switches or X restarts. Does not occur with DRI disabled or at all with 4.2.99.
>>
>
>If this only happens on server reset,
>http://www.penguinppc.org/~daenzer/XFree86-4.2/patches/r128-indirectBuffer.diff should help. This is also on the CVS trunk already, and the radeon driver has been fixed even better in DRI CVS.
>
Thanks, that patch fixes the problem.

And, forcing PCI mode allows concurrent DRI and Xv. I've had my system
loaded up continuusly to 99+% with makes, ping floods, Xv xine, and
DRI enabled glxgears for an hour, and could still startup Mozilla and
compose this.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
