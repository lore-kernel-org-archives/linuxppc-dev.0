Return-Path: <jonmasters@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.206])
	by ozlabs.org (Postfix) with ESMTP id 096632BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Oct 2004 23:31:01 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id 76so15115rnk
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Oct 2004 06:30:58 -0700 (PDT)
Message-ID: <35fb2e5904102106303edb204b@mail.gmail.com>
Date: Thu, 21 Oct 2004 14:30:58 +0100
From: Jon Masters <jonmasters@gmail.com>
To: Mark Powell <medp@primagraphics.com>
In-Reply-To: <41777D14.7090108@primagraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <41777D14.7090108@primagraphics.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: gdb on a 440GP ELDK
Reply-To: jonathan@jonmasters.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 21 Oct 2004 10:10:44 +0100, Mark Powell <medp@primagraphics.com> wrote:

> The system seems to basically run fine apart from the fact that gdb
> doesn't stop at any breakpoints.

Can you please provide an example? How are you running the program
being debugged? If it's a daemon, are you running it interactively or
trying to let it detach itself?

Jon.
