Return-Path: <jacmet@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B8D04B70C9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Jun 2009 17:31:58 +1000 (EST)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by ozlabs.org (Postfix) with ESMTP id DF30BDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jun 2009 17:31:57 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 13so162377fge.16
	for <linuxppc-dev@ozlabs.org>; Fri, 05 Jun 2009 00:31:55 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Byron Bradley <byron.bbradley@gmail.com>
Subject: Re: [PATCH] [POWERPC] 83xx: Add support for the Thecus N1200 NAS
	device
References: <alpine.DEB.2.00.0906042152330.7053@gamma>
	<20090605030850.GF2054@yookeroo.seuss>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Fri, 05 Jun 2009 09:31:53 +0200
In-Reply-To: <20090605030850.GF2054@yookeroo.seuss> (David Gibson's message of
	"Fri\, 5 Jun 2009 13\:08\:50 +1000")
Message-ID: <87ws7rxhjq.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, tim.ellis@mac.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "David" == David Gibson <david@gibson.dropbear.id.au> writes:

 David> On Thu, Jun 04, 2009 at 09:59:04PM +0100, Byron Bradley wrote:
 >> The Thecus N1200 is a NAS device with a single internal SATA disk and
 >> an eSATA port based on an MPC8347 SoC.

 David> Comments on a number of fairly minor device tree nits below:

 David> [snip]
 >> +	soc8349@e0000000 {
 >> +		#address-cells = <1>;
 >> +		#size-cells = <1>;
 >> +		device_type = "soc";
 >> +		compatible = "simple-bus";
 >> +		};
 >> +
 >> +		gpio1: gpio-controller@c00 {
 >> +			#gpio-cells = <2>;
 >> +			compatible = "fsl,mpc8347-gpio", "fsl,mpc8349-gpio";

 David> This actually is an 8349 board, yes?  Generally compatible should be
 David> listed from most specific to least specific, so the 8349 entry should
 David> go first.

No, it's an 8347, to the gpio compatible is fine, but the soc8349
should be changed to 8347 above.

-- 
Bye, Peter Korsgaard
