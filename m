Return-Path: <rlrevell@joe-job.com>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by ozlabs.org (Postfix) with SMTP id 374C367CB9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 04:43:34 +1100 (EST)
Subject: Re: Perl
From: Lee Revell <rlrevell@joe-job.com>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <4559F7F9.4070008@grandegger.com>
References: <1163458589.5313.71.camel@mindpipe>
	<4559F7F9.4070008@grandegger.com>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 12:42:58 -0500
Message-Id: <1163526178.14674.16.camel@mindpipe>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-11-14 at 18:08 +0100, Wolfgang Grandegger wrote:
> Lee Revell wrote:
> > I've been trying to cross compile Perl for a PPC440 board and it just
> > isn't happening.  Perl is probably the least amenable application to
> > cross compiling I've found.
> > 
> > I tried the instructions in the Cross/ directory of the Perl distro but
> > they don't work - "sh Configure" fails on my target because it expects a
> > full C development environment, which won't fit.
> > 
> > Is there any easy solution?  Can someone send me a binary?
> 
> Configure and make perl natively on your target platform. I have done it 
> some time ago with the ELDK.

I don't think this is an option, the perl build has too many
dependencies.

Lee
