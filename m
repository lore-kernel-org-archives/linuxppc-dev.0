Return-Path: <solca@guug.org>
Received: from guug (guug.org [168.234.203.30])
	by ozlabs.org (Postfix) with ESMTP id F194A67B66
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 08:07:14 +1000 (EST)
Date: Thu, 31 Aug 2006 17:07:12 -0500
To: Chun Chung Lo <cclo@astri.org>
Subject: Re: 2 Ethernet port operating in a PPC405EP system
Message-ID: <20060831220712.GA1713@guug.org>
References: <A7B1E4DD46AA7046A4398F745240F29402737D5F@ASPROEXG.astri.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <A7B1E4DD46AA7046A4398F745240F29402737D5F@ASPROEXG.astri.local>
From: Otto Solares <solca@guug.org>
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

On Thu, Aug 31, 2006 at 08:54:19AM +0800, Chun Chung Lo wrote:
> Hi,

Hi.

> I really do not know what happened about MediaMVP, could you mind giving
> me a review?

Sure, the problem with the MediaMVP is that it ships with a real old
and buggy kernel (specially the NIC driver) and with propietary kernel
modules, so you can't really upgrade the kernel.

I was succesful in booting a 2.6 kernel but without drivers for the
special hw I lost interest.

So I really hate vendors shipping buggy old kernels, that's all. :)

-otto
