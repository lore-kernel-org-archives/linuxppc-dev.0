Return-Path: <wd@denx.de>
To: David Jander <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC5121e, MBX driver, pvr.ko ...
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <200902060824.06851.david.jander@protonic.nl>
References: <200902060824.06851.david.jander@protonic.nl>
Date: Fri, 06 Feb 2009 20:17:10 +0100
Message-Id: <20090206191710.C16B78322908@gemini.denx.de>
Cc: Linuxppc-dev <Linuxppc-dev@ozlabs.org>, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear David,

In message <200902060824.06851.david.jander@protonic.nl> you wrote:
> 
> I decided to try out Application Note AN3793 from Freescale (3D Graphics on 
> the ADS512101 Board Using OpenGL ES).
> 
> I started trying to load the provided (binary!) kernel modules into our 
> kernel, but I am geeting errors inserting the modules using 

The binary kernel modules are a mess. Not  only  they  are  a  pretty
clear  GPL license violation (and I wonder what Freescale is going to
do to sort this out), but it effectively always locks you down to the
specific LTIB kernel version (and probably even to  a  specific  DTS)
they were built against. Open source? Forget it.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Send lawyers, guns and money..."  - Lyrics from a Warren Zevon song
