Message-ID: <3E67236D.8010908@maxxio.at>
Date: Thu, 06 Mar 2003 11:31:09 +0100
From: Reinhard Schwillinsky <rsw@maxxio.at>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rg_Huwig?= <jhuwig@intec-isdn.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [linuxppc-embedded:] source of supply for MAC addresses
References: <NDBBLLJKOLDLFBOALAOJGEPACDAA.jhuwig@intec-isdn.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


First you should request an OUI (see
http://standards.ieee.org/regauth/oui/index.shtml). It is used as the
left part (3 bytes) of an ethernet MAC address.
Then you have to assign the other 3 bytes and ensure that one MAC
address never is used twice.
To accomplish this you can use the serial number of your device or
special chips that contain such unique numbers.

rgds
Reinhard

Jörg Huwig wrote:
> Hi all,
>
> for an own manufactured device based on a Motorola MPC850,
> we need unique MAC addresses for the ethernet port.
> Could anyone give me the information were we can get such unique addresses?
>
> Thanks in advance,
>
>
> Joerg
>
>
>


--
----------------------------------------------------
Reinhard Schwillinsky        Tel.: ++43/1/205 255/210
Maxxio technologies GmbH     Fax.: ++43/1/205 255/900
Prinz Eugen Strasse 8        A-1040 Vienna/Austria


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
