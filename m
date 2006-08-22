Return-Path: <rlrevell@joe-job.com>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by ozlabs.org (Postfix) with SMTP id DD26467BA7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 04:27:19 +1000 (EST)
Subject: RE: Deactivate serial console?
From: Lee Revell <rlrevell@joe-job.com>
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
In-Reply-To: <1156269458.10565.182.camel@mindpipe>
References: <91B22F93A880FA48879475E134D6F0BE02EEA435@CA1EXCLV02.adcorp.kla-tencor.com>
	<1156269458.10565.182.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 14:27:24 -0400
Message-Id: <1156271244.10565.200.camel@mindpipe>
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

On Tue, 2006-08-22 at 13:57 -0400, Lee Revell wrote:
> On Tue, 2006-08-22 at 10:46 -0700, Howard, Marc wrote:
> > "stty -F /dev/console 0" or the equivalent in code does the trick for me
> > but it might be implementation dependent.
> > 
> 
> That works for disabling the console but now I can't re-enable it.  stty
> -F /dev/console 115200 does not restore serial console access.

OK, for the benefit of the list readers, this solution does work.
However the disable command must be issued from telnet/SSH prompt - if
issued from the a serial console, the serial console locks up and cannot
be restored without a reboot.

Lee
