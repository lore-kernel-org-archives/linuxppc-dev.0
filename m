Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id A0DA2DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 23:04:29 +1000 (EST)
Message-ID: <49FAF351.4010409@mlbassoc.com>
Date: Fri, 01 May 2009 07:04:17 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Subject: Using archaic I2C with OF
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'd like to use an existing I2C driver (a touchscreen device)
with my 834x based platform.  How do I arrange to provide
platform data (i2c_client->dev.platform_data) from my OF world?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
