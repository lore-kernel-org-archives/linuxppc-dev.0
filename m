Message-ID: <3A7AFD6B.67378DDD@mvista.com>
Date: Fri, 02 Feb 2001 10:33:15 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Subodh Nijsure <SNijsure@SkyStream.com>
CC: "'jeffrey.d.kowing1@jsc.nasa.gov'" <jeffrey.d.kowing1@jsc.nasa.gov>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: ping says unknown protocol icmp I have /etc/protocols file.
References: <B25E2E5A003CD311B61E00902778AF2A0148B6C5@SERVER1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Subodh Nijsure wrote:
>
> Hello Jeffrey,
>
> Thanks, indeed it was an issue of having libresolv library
>
> I copied libresolve to /usr/lib when building the ramdisk and
> ping works now.
>
> BTW, is there a something equivalent to  ldd in powerpc world, so one
> can find out which shared library an executable is linked with?
> I have 8xx environment from MontaVista and I don't see ppc_8xx-ldd
>
> /Subodh Nijsure

Yes, ldd is /bin/ldd in the target file system.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
