Message-ID: <B25E2E5A003CD311B61E00902778AF2A0148B61A@server1.skystream.com>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: "'Tobias Otto-Adamczak'" <tobias.otto-adamczak@e-technik.tu-chemnitz.de>,
        Subodh Nijsure <SNijsure@SkyStream.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Connecting to powerpc target via wiggler.
Date: Tue, 12 Dec 2000 07:42:54 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



>
> > Has anybody been successful in connecting to the powerpc board
> > using the BDM wiggler from MACRAIGOR system?
>
> AFAIK Macraigor sells some MS-Windows code that makes the wiggler work
> with the MS-Windows versions of GDB. I searched the web some
> months ago if
> someome succeeded using powerpc board, wiggler, GDB and linux
> but it seems
> there is no (free) solution available.
>
> Ciao - Tobias

Actually I got it working.

Here is my setup.

On my linux machine installed vmware (http://www.vmware.com )
and NT machine, installed the wiggler software.
Also under NT installed rproxy.
It can be downloaded from link http://www.std.com/qqi/labslave/rproxy.html
Make sure to install rproxy in same directory as wigglers.dll

Now you can start rproxy under NT with command line
rproxy --port=5555 ppcdbm wigglers.dll

Now under linux connect to this rproxy & thus the wiggler from gdb
using command

	target remote IPAddress:5555

So you can do all of this on one machine, all you need is vmware and rproxy
software.

Hope this helps.


/Subodh Nijsure
SkyStream Networks

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
