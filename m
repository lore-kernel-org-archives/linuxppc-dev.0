Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id B64A0DDF14
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Sep 2008 11:44:19 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so25769ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 04 Sep 2008 18:44:18 -0700 (PDT)
Date: Thu, 4 Sep 2008 21:43:24 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Subject: Re: One image for two different core
Message-ID: <20080905014324.GA3371@yoda.jdub.homelinux.org>
References: <F795765B112E7344AF36AA9112796415069F1682@xmb-sjc-212.amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F795765B112E7344AF36AA9112796415069F1682@xmb-sjc-212.amer.cisco.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2008 at 05:18:45PM -0700, Bizhan Gholikhamseh (bgholikh) wrote:
>Hi All,
>
>I am doing a feasibility study whether I can have one image for two
>different  platform with e300 ad e500 core. The idea is uboot will
>detect which type of the processor is running and pass the information
>to the early Linux startup, then the code will configure itself based on
>what type of core it is.

That doesn't really sound possible to me with a single kernel binary.  If
I remember correctly, e300 is a 603e style CPU, and e500 is a BookE CPU.
They have totally different MMUs (among other things), which means you
would really need to separate kernel binaries to support that.

I'm not an Freescale core expert though, so I might be confused or don't
know of some way that would work.

josh
