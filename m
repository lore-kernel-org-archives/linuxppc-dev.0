Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id E7B04B7BCC
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 03:19:39 +1100 (EST)
Message-ID: <4B30F165.2060300@grandegger.com>
Date: Tue, 22 Dec 2009 17:18:45 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: I2C bus clock on MPC85XX systems
References: <4B30E7F5.8080201@embedded-sol.com>
In-Reply-To: <4B30E7F5.8080201@embedded-sol.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Felix Radensky wrote:
> Hi,
> 
> Almost all MPC85XX based systems have the compatible=:"fsl-i2c" in
> respective
> i2c device tree nodes. This causes FSL i2c driver to use the following
> "backward
> compatible" values: FSR=0x31 DFSR=0x10. This is regardless of CCB clock
> frequency and i2c clock prescaler.
> 
> On my custom MPC8536 based board with 432MHz CCB clock this results in
> 65KHz i2c clock frequency (checked with scope). U-Boot correctly configures
> the clock to 400KHz.
> 
> I've fixed the problem by modifying device tree to use different
> compatible value,
> similar to what socrates board does. Is this the right approach ?

Are you aware of the properties described in
"Documentation/powerpc/dts-bindings/fsl/i2c.txt":

http://lxr.linux.no/#linux+v2.6.32/Documentation/powerpc/dts-bindings/fsl/i2c.txt

Wolfgang.
