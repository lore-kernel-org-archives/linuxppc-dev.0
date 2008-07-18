Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 7F816DEC59
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jul 2008 05:32:14 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KJvgZ-0005ex-41
	for linuxppc-embedded@ozlabs.org; Fri, 18 Jul 2008 12:32:11 -0700
Message-ID: <18536319.post@talk.nabble.com>
Date: Fri, 18 Jul 2008 12:32:11 -0700 (PDT)
From: Victor Gallardo <vgallardo@amcc.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Add AMCC Arches DTS
In-Reply-To: <20080716073913.100d259a@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <1216186476-28018-1-git-send-email-fkan@amcc.com>
	<20080716073913.100d259a@zod.rchland.ibm.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> Could you convert this to a dts-v1 file please?  All the in-tree DTS
> files are dts-v1 and I'd very much like to keep it that way.

OK. Will look into this. I used the glacier.dts file as a base line. Is the
glacier.dts file in dts-v1 format?

> <snip>

> If this is a dual-460GT, why is there only one CPU node listed?  Is it
> simply because Linux will only see one CPU as it is an AMP
> configuration?

Yes, the board is a dual processor board with each processor providing
independent resources. Each CPU will boots up with its own Linux image.

Victor Gallardo
-- 
View this message in context: http://www.nabble.com/-PATCH--Add-AMCC-Arches-DTS-tp18480767p18536319.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
