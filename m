Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 274AFDE014
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 07:38:11 +1100 (EST)
Date: Fri, 26 Jan 2007 14:37:58 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 10/14] ps3: get firmware version
Message-ID: <20070126203758.GC17317@localdomain>
References: <45B81891.1010309@am.sony.com> <20070126025955.GE18537@lst.de>
	<45BA4DD5.2030106@am.sony.com>
	<1169843138.24996.114.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1169843138.24996.114.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> > Anyway, that is the need, the question is where to make it
> > available.  I thought /proc/cpuinfo already has the platform type
> > (coming from the generic powerpc code), so it would be convenient
> > for utilities to have the firmware version there too.  I don't
> > think parsing the dmsg is an option for minimal configs like
> > bootloaders and distro installers, as they may not keep the boot
> > messages around, and in general doesn't seem a reliable way.  If
> > you can make a suggestion, I'd like to hear it.
>
> Yeah, /proc/cpuinfo is actually a fairly convenient place for that...

Other firmwares provide a property in the device tree with version
information, for example on Power5:

$ lsprop /proc/device-tree/openprom/ibm,fw-vernum_encoded
/proc/device-tree/openprom/ibm,fw-vernum_encoded "SF225_096"
