Return-Path: <rlrevell@joe-job.com>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by ozlabs.org (Postfix) with SMTP id 3223E67B52
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 03:28:28 +1000 (EST)
Subject: CROSS_COMPILE - namespace collision
From: Lee Revell <rlrevell@joe-job.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 13:28:22 -0400
Message-Id: <1151515702.15513.40.camel@mindpipe>
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

I have not been able to get readline 5.1 to compile with the ELDK - it
places the value of CROSS_COMPILE in the gcc command line and thus fails
with "No such file or directory".  I emailed the readline maintainer and
got this response: 

"The bash Makefiles expect CROSS_COMPILE
to expand to a preprocessor option, and will fail otherwise."

I can make it work with a hack, but I thought this might be interesting
info.

Any comments?

Lee
