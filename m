Return-Path: <R65777@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DD0AC2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 16:01:27 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Liu Qiang-B32616
 <B32616@freescale.com>
Subject: RE: SATA FSL and upstreaming
Date: Thu, 16 May 2013 06:01:44 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
In-Reply-To: <1368683156.9603.34.camel@pasglop>
Content-Type: multipart/mixed;
 boundary="_002_6A3DF150A5B70D4F9B66A25E3F7C888D0701C307039SN2MPN101203_"
MIME-Version: 1.0
Cc: Fleming Andy-AFLEMING <afleming@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_002_6A3DF150A5B70D4F9B66A25E3F7C888D0701C307039SN2MPN101203_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Ben=
jamin
> Herrenschmidt
> Sent: Thursday, May 16, 2013 11:16 AM
> To: Liu Qiang-B32616
> Cc: linuxppc-dev@lists.ozlabs.org; Fleming Andy-AFLEMING; Xie Shaohui-B21=
989
> Subject: Re: SATA FSL and upstreaming
>=20
> On Thu, 2013-05-16 at 14:47 +1000, Benjamin Herrenschmidt wrote:
> > Hi folks !
> >
> > So I was trying to use my 5020ds to test some stuff today. Since I
> > hadn't used it in a while, I decided to "upgrade" it to the latest NOR
> > etc...
>=20
> On another note, I can't seem to get any PCIe card recognized in any slot=
...
>=20
> Can you give me an example config of the DIP switches that is known to wo=
rk with
> some slots ? Is there some EEPROM config needed ? If yes, any pointers ? =
(I
> can't quite make sense of either u-boot or the doc there).

Can you give RCW dump?
Or can try the attached RCW.

Thanks
-Bharat

>=20
> Thanks,
> Ben.
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--_002_6A3DF150A5B70D4F9B66A25E3F7C888D0701C307039SN2MPN101203_
Content-Type: application/octet-stream; name="rcw_15g_2000mhz.rcw"
Content-Description: rcw_15g_2000mhz.rcw
Content-Disposition: attachment; filename="rcw_15g_2000mhz.rcw"; size=794;
	creation-date="Thu, 16 May 2013 06:00:23 GMT";
	modification-date="Mon, 22 Apr 2013 18:21:32 GMT"
Content-Transfer-Encoding: base64

LyoKICogMTVnIGNvbmZpZ3VyYXRpb24gLS0gMyBTR01JSSAxZyBwb3J0cyAgKyAyIFJHTUlJICsg
MSBYQVVJCiAqCiAqIEZyZXF1ZW5jaWVzOgogKgogKiBTeXMgQ2xvY2sgLS0gMTMzLjMzIE1oegog
KiBTRFJFRkNMSzFfRlNFTDogMTAwIE1IegogKiBTRFJFRkNMSzJfRlNFTDogMTI1IE1IegogKiBT
RFJFRkNMSzNfRlNFTDogMTI1IE1IegogKgogKiBDb3JlIC0tIDIwMDAgTUh6IChNdWwgMTUpCiAq
IFBsYXRmb3JtIC0gODAwIE1IeiAoTXVsIDYpCiAqIEREUiAtLSAxMzMzLjMzIE1IeiAoTXVsIDEw
KQogKiBGTUFOIC0tIDYwMCBNSHogKENDMiBQTEwpLzIgKE11bCA5KQogKgogKiBTZXJkZXMgQmFu
azEgLS0gQ2xvY2sgUmF0aW8gNTA6MSAvMiBmb3IgUENJZSBhbmQgNTA6MS8xIGZvciBTR01JSQog
KiBMQU5FIEEsIEIsIEMsIEQgLzIgZm9yIFBDSWUKICogQmFuazIgICAgLS0gMjU6MSAvMQogKiBC
YW5rMyAgIC0tIDI0OjEgLzEKICovCgojaW5jbHVkZSA8cDUwMjAucmN3aT4KClNZU19QTExfUkFU
PTYKTUVNX1BMTF9DRkc9MQpNRU1fUExMX1JBVD0xMApDQzFfUExMX1JBVD0xNQpDQzJfUExMX1JB
VD05ClNSRFNfUFJUQ0w9NTQKU1JEU19SQVRJT19CMT00ClNSRFNfRElWX0IxPTI0ClNSRFNfUkFU
SU9fQjI9MgpTUkRTX1JBVElPX0IzPTUKU1JEU19MUERfQjE9NApTUkRTX0xQRF9CMz0xMgpTUkRT
X0VOPTEKUEJJX1NSQz0wYjExMDEKQk9PVF9MT0M9MjkKRk1fQ0xLX1NFTD0xCkRSQU1fTEFUPTEK
STJDPTQKR1BJTz0xClVBUlQ9NgoKLy8gI2luY2x1ZGUgIi4uLy4uL2EwMDQ1ODAucmN3Igo=

--_002_6A3DF150A5B70D4F9B66A25E3F7C888D0701C307039SN2MPN101203_--
