Return-Path: <jcrigby@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.182])
	by ozlabs.org (Postfix) with ESMTP id A17A3DE06D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Mar 2007 08:17:28 +1100 (EST)
Received: by ik-out-1112.google.com with SMTP id c29so285794ika
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 07 Mar 2007 13:17:26 -0800 (PST)
Message-ID: <4b73d43f0703071317o7ae5e531s5eb4b390d41a1b88@mail.gmail.com>
Date: Wed, 7 Mar 2007 14:17:25 -0700
From: "John Rigby" <jrigby@freescale.com>
Sender: jcrigby@gmail.com
To: linuxppc-embedded@ozlabs.org, "Matthias Fechner" <idefix@fechner.net>
Subject: Re: Howto read I2C on MPC5200 Lite
In-Reply-To: <20070307122430.GA73298@server.idefix.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070307122430.GA73298@server.idefix.lan>
Reply-To: jcrigby@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I use i2c-tools which once lived at http://secure.netroedge.com/~lm78/
it is to be a subset of lm_sensors www.lm-sensors.org.

You can get a copy of i2c-tools from:
http://www.bitshrine.org/gpp/i2c_tools-2jun05.tar.gz
and a patch
http://www.bitshrine.org/gpp/i2c-tools-device.patch

Once you compile it and have created the device nodes
you should be able to scan with i2cdetect <busnum>.

On a stock lite5200b the only thing that shows up is a serial
eeprom at address 0x50.

You can then use i2cdump <busnum> <addr> to dump the device
and i2cset <busnum> <addr> <offset> <value> to write to it.
