Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B01FF67C52
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 08:50:36 +1100 (EST)
To: Lee Revell <rlrevell@joe-job.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Perl 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 14 Nov 2006 12:42:58 EST."
	<1163526178.14674.16.camel@mindpipe>
Date: Tue, 14 Nov 2006 22:50:34 +0100
Sender: wd@denx.de
Message-Id: <20061114215034.292D7352B86@atlas.denx.de>
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

In message <1163526178.14674.16.camel@mindpipe> you wrote:
>
> > Configure and make perl natively on your target platform. I have done it 
> > some time ago with the ELDK.
> 
> I don't think this is an option, the perl build has too many
> dependencies.

I confirm that building Perl on the target system using the ELDK root
file system over NFS works fine.

Just try it out. It may be slow, but CPU cyles are cheap.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A meeting is an event at which the minutes are kept and the hours are
lost.
