Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3DEC78AC.7080106@intracom.gr>
Date: Tue, 03 Dec 2002 11:26:04 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Reinhard Schwillinsky <rsw@maxxio.at>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [linuxppc-embedded:] Re: QMC driver for 860?
References: <IGEFJKJNHJDCBKALBJLLEEHBFIAA.joakim.tjernlund@lumentis.se> <3DEB7A88.1030205@intracom.gr> <3DEC7281.80202@maxxio.at>
In-Reply-To: <3DEC7281.80202@maxxio.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Reinhard Schwillinsky wrote:

>
> Pantelis Antoniou wrote:
>
>> [...]
>> P.S. Is there anyone in the list interested in this?
>> Should I clean it up, and submit it?
>>
> Yes! I am interested in this!
> rg Reinhard
>
> --
> ----------------------------------------------------
> Reinhard Schwillinsky        Tel.: ++43/1/205 255/210
> Maxxio technologies GmbH     Fax.: ++43/1/205 255/900
> Prinz Eugen Strasse 8        A-1040 Vienna/Austria
>
>
>
>
>
OK, since there is apparently great interest (of two persons)
I'll try and clean it up, so that only the relevant QMC bits remain.
I will also add the change suggested by Joakim.

In the meantime I'll try to find some hosting place for the
current code so that you can see it.

Keep in mind that a QMC driver by itself is not interesting.
It is some kind of a meta-driver, that needs another
'instantazation' driver to make it something useful.
I.e. it could be a simple read/write driver for connection
to a codec, or it could be a ISDN driver.

Anyway, please be patient.

Pantelis Antoniou
INTRACOM S.A.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
