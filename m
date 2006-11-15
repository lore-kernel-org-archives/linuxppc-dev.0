Return-Path: <rlrevell@joe-job.com>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by ozlabs.org (Postfix) with SMTP id C3BDE67D0C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 03:22:19 +1100 (EST)
Subject: Re: Perl
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian <adrian@it-live.co.uk>
In-Reply-To: <024801c70886$dd8b9220$3264a8c0@adrianlaptop>
References: <024801c70886$dd8b9220$3264a8c0@adrianlaptop>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 11:21:44 -0500
Message-Id: <1163607705.14674.110.camel@mindpipe>
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

On Wed, 2006-11-15 at 08:22 +0100, Adrian wrote:
> Just found this (notes!) :-
> 
> 'Perl 5.6.4
> 
> Configure with threads, perlio abstraction layer and default libraries.
> 
> Copy the etc/Digest directory from perl-5.8.2
> 
> Enable MD5 to be statically loaded in perl sh Configure
> 
> Also enable threaded'
> 
> It was a lot of messing about AFAICR.
> 
> Adrian Atkins.
> 

Is this a cross compile or a native build you're describing?  If it's a
cross compile do you use the method from Cross/README or INSTALL in the
perl directory?

Lee
