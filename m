Return-Path: <edo@onkeh.net>
Received: from pulsar.hytekhosting.com (pulsar.hytekhosting.com
	[208.101.48.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D723BDDEF3
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 09:01:42 +1100 (EST)
Received: from onkehf2 by pulsar.hytekhosting.com with local (Exim 4.63)
	(envelope-from <edo@onkeh.net>) id 1HOhj1-0006sI-LZ
	for linuxppc-dev@ozlabs.org; Tue, 06 Mar 2007 17:01:39 -0500
Message-ID: <29265.81.170.117.164.1173218499.squirrel@onkeh.net>
In-Reply-To: <Pine.LNX.4.62.0703062016450.4463@pademelon.sonytel.be>
References: <29902.81.170.115.218.1173205803.squirrel@onkeh.net>
	<Pine.LNX.4.62.0703062016450.4463@pademelon.sonytel.be>
Date: Tue, 6 Mar 2007 17:01:39 -0500 (EST)
Subject: Re: Updated ps3fb usage?
From: "Edward Strong" <edo@onkeh.net>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I modified ps3fb to support the standard fbdev modedb framework, so you
> should
> be able to say e.g. `video=720p' or `video=ps3fb:720p' now.
>
> It should still work the old way (`video=ps3fb:mode:%u'), though (I'll
> give it
> a try when I get back to the office).
>
> Gr{oetje,eeting}s,

Thanks Geert, just tried this and I'm still getting a "no signal" from my
TV after kboot, I'm pretty sure it's booting fine since I can see
hard-drive activity and the system reboots on ctrl+alt+delete.

My last working compile was version 2.6.20-gd96197dd.  I used the
ps3_defconfig, and my TV supports 480p/720p/1080i so not quite sure where
I'm going wrong here.  Any pointers would be much appreciated.

Edward
