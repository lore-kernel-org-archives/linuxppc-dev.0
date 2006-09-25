Return-Path: <Tord.Andersson@combitech.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Lite5200 NFS mount issue
Date: Mon, 25 Sep 2006 08:54:15 +0200
Message-ID: <18CE82D3EF6EA84F9A1A79D6051A0900285010@CORPAPPL020.corp.saab.se>
From: "Andersson Tord " <Tord.Andersson@combitech.se>
To: "Edward Jubenville" <edjubenville@adelphia.net>,
	<Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Thanks for your reply! However, I don't think we have a network or
switch related issue here,=20
as the problem is also found when using a crossed ethernet-cable between
the host and the target.

Best regards,

Tord


>=20
> You may not be having a board problem or a kernel problem.  I=20
> had exactly the same problem with an almost identical=20
> configuration as you.  Using Etherreal at various points in=20
> my network, I found that an Ethernet switch in the=20
> communication path was dropping packets before the board ever=20
> saw them.  I solved it the same way that you did (with=20
> rsize/wsize), and it has worked fine ever since.
>=20
> See my post on 7/26/2006, subject "Re: Slow boot with NFS,=20
> server not responding".
>=20
> Ed Jubenville
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org=20
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
