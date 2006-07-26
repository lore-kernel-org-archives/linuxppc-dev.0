Return-Path: <rlrevell@joe-job.com>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by ozlabs.org (Postfix) with SMTP id 4FC1067B5E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jul 2006 08:00:23 +1000 (EST)
Subject: Re: Serial issue
From: Lee Revell <rlrevell@joe-job.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <1153950324.2927.6.camel@mindpipe>
References: <1153950324.2927.6.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 18:00:21 -0400
Message-Id: <1153951221.2927.10.camel@mindpipe>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2006-07-26 at 17:45 -0400, Lee Revell wrote:
> I'm trying to connect to a Yosemite 440 PPC board using the serial
> console.  I've tried everything in every Linux Serial FAQ and HOWTO but
> no matter what, I can receive but I cannot transmit.

I've resolved the problem - unlike my reference system, with this host,
hardware flow control must be disabled for it to work.

Sorry for the noise.

Lee
