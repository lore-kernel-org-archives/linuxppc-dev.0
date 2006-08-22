Return-Path: <rlrevell@joe-job.com>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by ozlabs.org (Postfix) with SMTP id 814FA67C14
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 03:54:56 +1000 (EST)
Subject: RE: Deactivate serial console?
From: Lee Revell <rlrevell@joe-job.com>
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
In-Reply-To: <91B22F93A880FA48879475E134D6F0BE02EEA435@CA1EXCLV02.adcorp.kla-tencor.com>
References: <91B22F93A880FA48879475E134D6F0BE02EEA435@CA1EXCLV02.adcorp.kla-tencor.com>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 13:55:00 -0400
Message-Id: <1156269300.10565.180.camel@mindpipe>
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
> stty -F /dev/console 0

Thanks - so if I read the man page correctly the 0 is interpreted as 0
baud, and I would re-enable it by "stty -F /dev/console 115200"?

Lee
