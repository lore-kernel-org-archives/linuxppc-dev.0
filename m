Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18377.2794.295733.915606@cargo.ozlabs.ibm.com>
Date: Sat, 1 Mar 2008 18:51:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexandr Smirnov <asmirnov@ru.mvista.com>
Subject: Re: [PATCH 0/4] Add Emerson KSI8560 board support
In-Reply-To: <20080229171114.GA14325@ru.mvista.com>
References: <20080229171114.GA14325@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexandr Smirnov writes:

>    I've fixed the code according to your comments.

None of the patches you sent have any patch description or commentary,
and that's not good enough.  Yes, it all might be completely clear and
obvious in your head as to what the KSI8560 is and why you have made
the various design decisions you have, but it isn't necessarily
obvious to other people, and you yourself probably won't remember in
two years' time.  So write a paragraph or two for each patch telling
us those sort of things.

I concede that patches that just add a defconfig or a dts often don't
need much of a description, although even then there may be choices
made where you could usefully give us a rationale in the patch
description.

Paul.
