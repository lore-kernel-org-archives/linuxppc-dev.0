Return-Path: <jwboyer@gmail.com>
Received: from mail-iw0-f204.google.com (mail-iw0-f204.google.com
	[209.85.223.204]) by ozlabs.org (Postfix) with ESMTP id DBA36B7D14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Feb 2010 12:03:30 +1100 (EST)
Received: by iwn42 with SMTP id 42so1619746iwn.9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 05 Feb 2010 17:03:29 -0800 (PST)
Date: Fri, 5 Feb 2010 20:03:14 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/4] Fix iMac iSight PCI bridge setup
Message-ID: <20100206010314.GP12001@hansolo.jdub.homelinux.org>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
	<20100205135546.GJ12001@hansolo.jdub.homelinux.org>
	<1265403466.8287.218.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1265403466.8287.218.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 06, 2010 at 07:57:46AM +1100, Benjamin Herrenschmidt wrote:
>On Fri, 2010-02-05 at 08:55 -0500, Josh Boyer wrote:
>> This works around the PCIe bridge setup on the iMac iSight boxen.
>
>Is this still needed ? I though I had fixed the root cause (incorrect
>setup of the bridge) a while back...

I honestly have no clue, and I have no means of actually testing this.  I have
an iMac running Fedora, but not the iSight version.  If you think it's fixed
then I can just drop the patch from the Fedora kernel and we can wait for
either silence or bug reports :)

josh
