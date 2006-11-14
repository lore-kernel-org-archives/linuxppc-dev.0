Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B774567CE9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 04:07:01 +1100 (EST)
Message-ID: <4559F7F9.4070008@grandegger.com>
Date: Tue, 14 Nov 2006 18:08:09 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Perl
References: <1163458589.5313.71.camel@mindpipe>
In-Reply-To: <1163458589.5313.71.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Lee Revell wrote:
> I've been trying to cross compile Perl for a PPC440 board and it just
> isn't happening.  Perl is probably the least amenable application to
> cross compiling I've found.
> 
> I tried the instructions in the Cross/ directory of the Perl distro but
> they don't work - "sh Configure" fails on my target because it expects a
> full C development environment, which won't fit.
> 
> Is there any easy solution?  Can someone send me a binary?

Configure and make perl natively on your target platform. I have done it 
some time ago with the ELDK.

Wolfgang.
