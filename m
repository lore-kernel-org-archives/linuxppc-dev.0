Return-Path: <rlrevell@joe-job.com>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by ozlabs.org (Postfix) with SMTP id 1DE87679FB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 03:57:33 +1000 (EST)
Subject: RE: Deactivate serial console?
From: Lee Revell <rlrevell@joe-job.com>
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
In-Reply-To: <91B22F93A880FA48879475E134D6F0BE02EEA435@CA1EXCLV02.adcorp.kla-tencor.com>
References: <91B22F93A880FA48879475E134D6F0BE02EEA435@CA1EXCLV02.adcorp.kla-tencor.com>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 13:57:38 -0400
Message-Id: <1156269458.10565.182.camel@mindpipe>
Mime-Version: 1.0
Cc: ppc <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-08-22 at 10:46 -0700, Howard, Marc wrote:
> "stty -F /dev/console 0" or the equivalent in code does the trick for me
> but it might be implementation dependent.
> 

That works for disabling the console but now I can't re-enable it.  stty
-F /dev/console 115200 does not restore serial console access.

Lee

> Marc W. Howard
> 
> > -----Original Message-----
> > From: 
> > linuxppc-embedded-bounces+marc.howard=kla-tencor.com@ozlabs.or
> g [mailto:linuxppc-embedded-bounces+marc.howard=kla->
> tencor.com@ozlabs.org] On Behalf Of Lee Revell
> > Sent: Tuesday, August 22, 2006 9:19 AM
> > To: ppc
> > Subject: Deactivate serial console?
> > 
> > We're developing a PPC440 based system for a customer who 
> > requires that
> > it be possible to disable/enable the serial console without a reboot.
> > Is this possible without hacking the kernel?
> > 
> > Lee
> > 
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > 
> 
