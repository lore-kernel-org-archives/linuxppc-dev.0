MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [linuxppc-embedded:] 8xx_io/enet.c
Date: Tue, 10 Dec 2002 12:05:09 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31938193@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@medcare.is>
To: "Reinhard Schwillinsky" <rsw@maxxio.at>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Reinhard Schwillinsky [mailto:rsw@maxxio.at]
> Sent: 10. desember 2002 10:43
> To: Kári Davíðsson
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: [linuxppc-embedded:] 8xx_io/enet.c
>
[snip snap]
> >
> > I am a litle unclear on the ethernet operation in whole.
>
> This has nothing to do with ethernet directly! Only a
> received ethernet
> packet cannot be stored. Higher protocols (f.e. TCP) should
> resend the
> missing data!

Yes that is the reason for my question... I.e. should I just trust the
TCP protocol....

But enabling CONFIG_ENET_BIG_BUFFERS got rid of the problem.

Thanks,

K.D.

>
>
> rgs Reinhard
>
>
> --
> ----------------------------------------------------
> Reinhard Schwillinsky        Tel.: ++43/1/205 255/210
> Maxxio technologies GmbH     Fax.: ++43/1/205 255/900
> Prinz Eugen Strasse 8        A-1040 Vienna/Austria
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
