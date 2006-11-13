Return-Path: <rlrevell@joe-job.com>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by ozlabs.org (Postfix) with SMTP id AAC0367F4D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 10:03:48 +1100 (EST)
Subject: Perl
From: Lee Revell <rlrevell@joe-job.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Mon, 13 Nov 2006 17:56:28 -0500
Message-Id: <1163458589.5313.71.camel@mindpipe>
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

I've been trying to cross compile Perl for a PPC440 board and it just
isn't happening.  Perl is probably the least amenable application to
cross compiling I've found.

I tried the instructions in the Cross/ directory of the Perl distro but
they don't work - "sh Configure" fails on my target because it expects a
full C development environment, which won't fit.

Is there any easy solution?  Can someone send me a binary?

Lee 
