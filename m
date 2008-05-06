Return-Path: <tnt@246tnt.com>
Received: from mailrelay010.isp.belgacom.be (mailrelay010.isp.belgacom.be
	[195.238.6.177]) by ozlabs.org (Postfix) with ESMTP id D4FB0DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 16:43:04 +1000 (EST)
Message-ID: <481FFDF5.7060208@246tnt.com>
Date: Tue, 06 May 2008 08:43:01 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Grant Likely <grant.likely@secretlab.ca>
Subject: [Fwd: fix for drivers/serial/mpc52xx_uart.c]
Content-Type: multipart/mixed; boundary="------------070103090303010302040608"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070103090303010302040608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Patch, obviously correct, sent to me personally instead of the list.

    Sylvain

--------------070103090303010302040608
Content-Type: message/rfc822;
 name="fix for drivers/serial/mpc52xx_uart.c.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix for drivers/serial/mpc52xx_uart.c.eml"

Return-Path: <sintonen@iki.fi>
X-Spam-Checker-Version: SpamAssassin 3.1.3-gr0 (2006-06-01) on
	leia.blacksnow.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=4.0 tests=BAYES_05
	autolearn=unavailable version=3.1.3-gr0
X-Original-To: tnt@246tNt.com
Delivered-To: tnt@leia.blacksnow.net
Received: from smtp10.kymp.net (smtp10.kymp.net [80.248.96.136])
	by leia.blacksnow.net (Postfix) with ESMTP id BEA8D752E
	for <tnt@246tNt.com>; Mon,  5 May 2008 21:42:05 +0200 (CEST)
Received: from adsl-215-228-47.kymp.net ([82.215.228.47])
	by smtp10.kymp.net (8.13.6/8.13.6) with ESMTP id m45KdEsC032038
	for <tnt@246tNt.com>; Mon, 5 May 2008 23:39:14 +0300
Date: Mon, 5 May 2008 23:39:14 +0300 (EEST)
From: Harry Sintonen <sintonen@iki.fi>
X-X-Sender: p@abit.home
To: tnt@246tNt.com
Subject: fix for drivers/serial/mpc52xx_uart.c
Message-ID: <Pine.LNX.4.64.0805052325120.4331@abit.home>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="656640-82358496-1210019954=:4331"
X-Virus-Scanned: by amavisd-new

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--656640-82358496-1210019954=:4331
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Here is a fix for the unterminated mpc52xx_uart_of_match array when 
CONFIG_PPC_MPC512x is not defined. Should be quite self explonary, but if 
not feel free to bug me about it.

Patch applies against 2.6.25 and 2.6.25.1 at least.

Patch can be credited to Harry Sintonen <sintonen@iki.fi>.


   Regards,
-- 
l=2001;main(i){float o,O,_,I,D;for(;O=I=l/571.-1.75,l;)for(putchar(--l%80?
i:10),o=D=l%80*.05-2,i=31;_=O*O,O=2*o*O+I,o=o*o-_+D,o+_+_<4+D&i++<87;);puts
("  Harry 'Piru' Sintonen <sintonen@iki.fi> http://www.iki.fi/sintonen");}
--656640-82358496-1210019954=:4331
Content-Type: TEXT/plain; charset=US-ASCII; name=patch.txt
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0805052339140.4331@abit.home>
Content-Description: 
Content-Disposition: attachment; filename=patch.txt

LS0tIGRyaXZlcnMvc2VyaWFsL21wYzUyeHhfdWFydC5jLW9yaWcJMjAwOC0w
NS0wNSAyMjo1MDo1Ni4wMDAwMDAwMDAgKzAzMDANCisrKyBkcml2ZXJzL3Nl
cmlhbC9tcGM1Mnh4X3VhcnQuYwkyMDA4LTA1LTA1IDIyOjUxOjU2LjAwMDAw
MDAwMCArMDMwMA0KQEAgLTEyMjAsMTAgKzEyMjAsMTAgQEANCiAJeyAuY29t
cGF0aWJsZSA9ICJtcGM1MjAwLXNlcmlhbCIsIC5kYXRhID0gJm1wYzUyeHhf
cHNjX29wcywgfSwNCiAjZW5kaWYNCiAjaWZkZWYgQ09ORklHX1BQQ19NUEM1
MTJ4DQogCXsgLmNvbXBhdGlibGUgPSAiZnNsLG1wYzUxMjEtcHNjLXVhcnQi
LCAuZGF0YSA9ICZtcGM1MTJ4X3BzY19vcHMsIH0sDQotCXt9LA0KICNlbmRp
Zg0KKwl7fSwNCiB9Ow0KIA0KIHN0YXRpYyBpbnQgX19kZXZpbml0DQogbXBj
NTJ4eF91YXJ0X29mX3Byb2JlKHN0cnVjdCBvZl9kZXZpY2UgKm9wLCBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICptYXRjaCkNCg==

--656640-82358496-1210019954=:4331--


--------------070103090303010302040608--
