MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: microcodepatch
Date: Thu, 25 Oct 2001 08:45:02 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31459351@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Der Herr Hofrat" <der.herr@hofr.at>
Cc: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Der Herr Hofrat [mailto:der.herr@hofr.at]
> Sent: 24. október 2001 19:02
> To: Kári Davíðsson
> Cc: Linux Embedded ppc (E-mail)
> Subject: Re: microcodepatch
>
>
>
> >
> > Hi,
> >
> > Are there any known issues regarding the I2C patch and the ethernet
> > driver?
> >
> > If I disable the microcode patch everything works fine,
> except the I2C
> > stuff.
> >
> > I am using the linuxppc_2_4_devel tree ported to our custom
> board with
> > ehternet on SCC2.
> >
> > Regards,
> >
> there might be - the dual-ported RAM of the CPM is quite
> limited and the micro-code goes in there - might be that the
> BD's for the SCC/ethernet are overlapping ??

The code seem to take care of that, i.e. using only the part of
dual-ported ram for BD's that is "never" overlapped.

K.D.
>
> hofrat
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
