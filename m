Return-Path: <dieter.schneider@berghof.com>
Received: from pegasus.berghof.com (unknown [145.253.135.72])
	by ozlabs.org (Postfix) with ESMTP id 782FF67F14
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 21:14:27 +1000 (EST)
Received: from BATEEE51 (batee-e51.be-int [10.255.241.51])
	by pegasus.berghof.com (8.12.10/8.12.10) with SMTP id j75B0w6O029948
	for <linuxppc-embedded@ozlabs.org>; Fri, 5 Aug 2005 13:00:58 +0200
From: "Dieter Schneider" <dieter.schneider@berghof.com>
To: "'linux embedded forum'" <linuxppc-embedded@ozlabs.org>
Date: Fri, 5 Aug 2005 13:00:52 +0200
Message-ID: <000f01c599ac$f2f36830$33f1ff0a@beint.local>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0010_01C599BD.B67C3830"
Subject: FW: Mpc5200 and ISP1106/1107 USB transceivers
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0010_01C599BD.B67C3830
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit



Mit freundlichen Grüßen
Berghof Automationstechnik GmbH

i.A. Dieter Schneider
- Entwicklungsingenieur -
http://www.berghof.com
mailto:dieter.schneider@berghof.com
Phone: +49 7121 894-129
Fax:   +49 7121 894-100
Adresse:
Harretstr.1  72800 Eningen
Deutschland


------=_NextPart_000_0010_01C599BD.B67C3830
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment

From: "Dieter Schneider" <dieter.schneider@berghof.com>
To: <Martin.Krause@tqs.de>
Subject: Mpc5200 and ISP1106/1107 USB transceivers
Date: Thu, 4 Aug 2005 17:14:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal

Hello Mr.Krause,

i made an investigation with Philips 1106/1107 USB transceivers not working
with low speed devices and mpc5200:
-usb 1.1 specification gives a rise/fall time for low speed devices in range
75ns to 300ns.
-"working" devices like Philips PDIUSBP11 have a rise/fall time of aprox.
120ns
-isp1106 / 1107 are in range of 180ns, that's inside usb 1.1 spec, but not
working with mpc5200

So its a problem of mpc5200, not philips 1106/1107 transceivers, who are
inside usb 1.1 spec. Setting transceiver speed pin konstant to High(=high
speed device) let the isp1106/1107 work also with low speed devices, but of
course with high speed rise/fall times (7..20ns). By the way, Phillips
PDIUSBP11 is obsolet. Giving the USB D+/D- an additional capacitive load
(for example 120pF, thats inside usb 1.1 spec ) makes an working Phillips
PDIUSBP11 not working.

Mit freundlichen Grüßen
Berghof Automationstechnik GmbH

i.A. Dieter Schneider
- Entwicklungsingenieur -
http://www.berghof.com
mailto:dieter.schneider@berghof.com
Phone: +49 7121 894-129
Fax:   +49 7121 894-100
Adresse:
Harretstr.1  72800 Eningen
Deutschland

------=_NextPart_000_0010_01C599BD.B67C3830--
