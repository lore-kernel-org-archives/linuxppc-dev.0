Return-Path: <nst@gersys.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 63D11DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 20:59:56 +1000 (EST)
Message-ID: <4A2504FB.90702@gersys.de>
Date: Tue, 02 Jun 2009 12:54:51 +0200
From: Stefan Strobl <nst@gersys.de>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: How to add i2c platform data in dts file
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi
I'm using the i2c/chips/tsl2550 driver. In the tsl2550_probe() function
the driver checks for platform data to set the operating_mode. I suppose
I can provide this data in my dts file but I don't know how to do that.
Currently my dts looks like this:

tsl2550@39 {
	compatible = "taos,tsl2550";
	reg = <0x39>;
};

Can anyone help me on how to set the operating_mode here?
Thanks, Stefan.
