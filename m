Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id B3B72DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 15:10:28 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: kvm-ppc-devel@lists.sourceforge.net
Subject: Re: [kvm-ppc-devel] [PATCH 3 of 3] [KVM POWERPC] PowerPC 440 KVM
	implementation
Date: Tue, 8 Apr 2008 07:09:31 +0200
References: <b07f3049f16483f80322.1207601614@localhost.localdomain>
	<200804080458.17783.arnd@arndb.de>
	<200804072319.11677.hollisb@us.ibm.com>
In-Reply-To: <200804072319.11677.hollisb@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804080709.32022.arnd@arndb.de>
Cc: kvm-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 April 2008, Hollis Blanchard wrote:
> If there is one thing I have learned in my various porting efforts, it's that 
> using a variable-sized type in an interface is just begging for trouble.
> 
> x86 uses fixed 64-bit variables here (even with x86-32), so that might be the 
> right solution here.

Right, I think there was even a conference presentation about this topic
done by one of us, right?

	Arnd <><
