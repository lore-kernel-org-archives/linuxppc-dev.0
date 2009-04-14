Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	by ozlabs.org (Postfix) with ESMTP id CDDB5DDFAA
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 19:23:09 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Help!Some memory doesn't work on PPC405Ex based board!
Date: Tue, 14 Apr 2009 11:23:02 +0200
References: <BAY114-W121B40A28E203154BC9209AB7F0@phx.gbl>
In-Reply-To: <BAY114-W121B40A28E203154BC9209AB7F0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200904141123.02495.sr@denx.de>
Cc: SunNeo <sunwx2001@hotmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 13 April 2009, SunNeo wrote:
> I'm porting Linux-2.6.29 on PPC405Ex based board, it's very similar to AMCC
> "Kilauea" evb.
>
> In my board, two 512MB DDRII memory is connected to 2 ranks of the 405Ex
> CPU. This 1GB memory works well at U-Boot-2009.01, but when I boot
> Linux-2.6.29, the kernel hangs somewhere.

Does it just hang "somewhere", or always at the same location? A random hangup 
could mean that you are having a memory problem (hardware, or wrong 
initialization).

> What interesting is, if I 
> configured the system to use only 512MB memory at U-Boot, the Linux can
> boot normally.

Are you using DIMM's on your platform? Or soldered chips? Which memory 
initialization code are you using in U-Boot? And which autocalibration code?

Did you do some intensive memory test?

Best regards,
Stefan
