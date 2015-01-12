Return-Path: <wcribbs@uslinc.com>
Received: from gproxy1-pub.mail.unifiedlayer.com
 (gproxy1-pub.mail.unifiedlayer.com [69.89.25.95])
 by lists.ozlabs.org (Postfix) with SMTP id 4658F1A0739
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jan 2015 11:37:27 +1100 (AEDT)
Received: from [66.214.75.151] (port=61194 helo=[192.168.1.8])
 by box925.bluehost.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.82) (envelope-from <wcribbs@uslinc.com>) id 1YAT0N-0003oC-FE
 for linuxppc-dev@lists.ozlabs.org; Sun, 11 Jan 2015 17:37:15 -0700
From: Bill Cribbs <wcribbs@uslinc.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_463738C8-5A7F-49DE-B071-3F7C731D9C85"
Subject: ppc + netfilter rx performance issues
Message-Id: <B34CDB21-8F89-41EB-8490-9D3E5B9A2096@uslinc.com>
Date: Sun, 11 Jan 2015 16:37:12 -0800
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_463738C8-5A7F-49DE-B071-3F7C731D9C85
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Folks,

Hope to humbly ask for some advice if this list is still active.  I=E2=80=99=
m supporting a legacy product and looking to improve networking =
performance.  It is a PPC460GT used as a bridge device with an ethernet =
1Gb (marvell), that routes packets to a pci network card (using igb).
Going in the pci interface and out tx to the network, we get a nominal =
700Mb, however=E2=80=A6

RX - to the marvell we see two things:
1. 300Mbps
2. sys =3D 100%

Any ideas?  I=E2=80=99m suspicious that packets are not being handled at =
a low level and getting copied through iptables rules to userspace.  =
Maybe there is a way to enable DMA to the benefit of incoming packets?

Linux mbu-100 2.6.33.1 #245 Fri Nov 1 17:41:21 PDT 2013 ppc GNU/Linux
Glacier=20

Thanks!
Bill






--Apple-Mail=_463738C8-5A7F-49DE-B071-3F7C731D9C85
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><span style=3D"font-size: 14px;" class=3D"">Hi =
Folks,</span><div class=3D""><span style=3D"font-size: 14px;" =
class=3D""><br class=3D""></span></div><div class=3D""><span =
style=3D"font-size: 14px;" class=3D"">Hope to humbly ask for some advice =
if this list is still active. &nbsp;I=E2=80=99m supporting a legacy =
product and looking to improve networking performance. &nbsp;It is a =
PPC460GT used as a bridge device with an ethernet 1Gb (marvell), that =
routes packets to a pci network card (using igb).</span></div><div =
class=3D""><span style=3D"font-size: 14px;" class=3D"">Going in the pci =
interface and out tx to the network, we get a nominal 700Mb, =
however=E2=80=A6</span></div><div class=3D""><span style=3D"font-size: =
14px;" class=3D""><br class=3D""></span></div><div class=3D""><span =
style=3D"font-size: 14px;" class=3D"">RX - to the marvell we see two =
things:</span></div><div class=3D""><span style=3D"font-size: 14px;" =
class=3D"">1. 300Mbps</span></div><div class=3D""><span =
style=3D"font-size: 14px;" class=3D"">2. sys =3D 100%</span></div><div =
class=3D""><span style=3D"font-size: 14px;" class=3D""><br =
class=3D""></span></div><div class=3D""><span style=3D"font-size: 14px;" =
class=3D"">Any ideas? &nbsp;I=E2=80=99m&nbsp;suspicious that packets are =
not being handled at a low level and getting copied through iptables =
rules to userspace. &nbsp;Maybe there is a way to enable DMA to the =
benefit of&nbsp;incoming packets?</span></div><div class=3D""><span =
style=3D"font-size: 14px;" class=3D""><br class=3D""></span></div><div =
class=3D""><span style=3D"font-family: Calibri, sans-serif; font-size: =
14px;" class=3D"">Linux mbu-100 2.6.33.1 #245 Fri Nov 1 17:41:21 PDT =
2013 ppc GNU/Linux</span></div><div class=3D""><span style=3D"font-family:=
 Calibri, sans-serif; font-size: 14px;" =
class=3D"">Glacier&nbsp;</span></div><div class=3D""><span =
style=3D"font-family: Calibri, sans-serif; font-size: 14px;" =
class=3D""><br class=3D""></span></div><div class=3D""><span =
style=3D"font-family: Calibri, sans-serif; font-size: 14px;" =
class=3D"">Thanks!</span></div><div class=3D""><span style=3D"font-family:=
 Calibri, sans-serif; font-size: 14px;" class=3D"">Bill</span></div><div =
class=3D""><br class=3D""></div><div class=3D""><br class=3D""></div><div =
class=3D""><br class=3D""></div><div class=3D""><div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D""></div></div></body></html>=

--Apple-Mail=_463738C8-5A7F-49DE-B071-3F7C731D9C85--
