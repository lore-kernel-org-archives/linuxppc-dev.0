Message-ID: <B25E2E5A003CD311B61E00902778AF2A0148B6C5@SERVER1>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: "'jeffrey.d.kowing1@jsc.nasa.gov'" <jeffrey.d.kowing1@jsc.nasa.gov>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: ping says unknown protocol icmp I have /etc/protocols file.
Date: Fri, 2 Feb 2001 07:18:09 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Jeffrey,


Thanks, indeed it was an issue of having libresolv library

I copied libresolve to /usr/lib when building the ramdisk and
ping works now.

BTW, is there a something equivalent to  ldd in powerpc world, so one
can find out which shared library an executable is linked with?
I have 8xx environment from MontaVista and I don't see ppc_8xx-ldd

/Subodh Nijsure

> -----Original Message-----
> From: Jeffrey D. Kowing [mailto:jeffrey.d.kowing1@jsc.nasa.gov]
> Sent: Friday, February 02, 2001 5:56 AM
> To: Subodh Nijsure
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: ping says unknown protocol icmp I have /etc/protocols file.
>
>
>
> Subodh Nijsure writes:
>  >
>  > I have 2.4.1 running on my board with ramdisk loading etc.
>  >
>  > However when I try to use ping it says unknown protocol icmp.
>  >
>  > I have searched the mailing list archive and made sure
> that I have correct
>  > /etc/protocols, /etc/services files.
>
> Had a similar problem recently.  Sadly, my little brain does not
> exactly remember the solution, but I believe the problem was that I
> did not have one of the necessary libraries on my ramdisk that allowed
> ping to lookup the icmp protocol in the files you mention.
>
> I think it was one of those libresolv* or libnss* libraries.
>
>
> --
> Jeff Kowing
> jeffrey.d.kowing1@jsc.nasa.gov
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
