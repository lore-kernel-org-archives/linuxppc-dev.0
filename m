Return-Path: <mark@glines.org>
Received: from squawk.glines.org (squawk.glines.org [72.36.206.66])
	by ozlabs.org (Postfix) with ESMTP id 60B53DDF12
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Dec 2006 07:53:35 +1100 (EST)
Message-ID: <45942EBF.5060201@glines.org>
Date: Thu, 28 Dec 2006 12:53:19 -0800
From: Mark Glines <mark@glines.org>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: kurobox kernel
References: <fa.ne7N9dqjDz5qS4D/fowPKdPc4ZY@ifi.uio.no>
	<fa.pM17YEcICUlveSt/vbSKGv6sFWk@ifi.uio.no>
	<45902A6F.4000100@glines.org>
	<Pine.LNX.4.60.0612252128530.3424@poirot.grange>
	<459046FE.9030008@glines.org>
	<Pine.LNX.4.60.0612252349040.3424@poirot.grange>
	<45905997.5080403@glines.org>
	<Pine.LNX.4.60.0612260019430.3424@poirot.grange>
	<45918294.3080303@glines.org>
	<Pine.LNX.4.60.0612262159180.3245@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0612262159180.3245@poirot.grange>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:
> Look here: http://www.kurobox.com/revolution/downloads/contest/patchREADME 
> for a somewhat rough README and here 
> http://www.kurobox.com/revolution/downloads/contest/patches.zip are the 
> patches (sorry about the zip - that was revolution's format of choice...)

Thanks a bunch.  A RAM build of uBoot boots the old kernel fine, so I'll 
replace my older uBoot with it.  The only trouble I had was stripping 
carriage returns out of the patches in that zipfile; after that, 
everything went pretty smoothly.

I noticed uBoot is looking for a *.dtb file, as well as the kernel 
image.  The patchREADME refers to a "dtc" tool, but the URL it gives 
(http://ozlabs.org/~dgibson/dtc/dtc.tar.gz) does not exist.  So I 
googled and found git://ozlabs.org/srv/projects/dtc/dtc.git, and tried 
to compile kuroboxHG.dts, with the command line specified within that file:

$ dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts
DTC: dts->dtb  on file "kuroboxHG.dts"
ERROR: Missing /chosen node
Input tree has errors

So, uh... is the *.dts file in 2.6.20-rc2 bad, or am I compiling it 
wrongly?  (And is this normally done by hand, or as part of the kernel 
build process?)

Thanks,

mark
