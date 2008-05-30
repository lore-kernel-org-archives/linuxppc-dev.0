Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-148.bluehost.com (outbound-mail-148.bluehost.com
	[67.222.38.38]) by ozlabs.org (Postfix) with SMTP id E548CDDE22
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 14:02:26 +1000 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix rpadlpar pci hotplug driver sysfs usage
Date: Thu, 29 May 2008 21:02:17 -0700
References: <20080530034134.E2D81DDEE1@ozlabs.org>
In-Reply-To: <20080530034134.E2D81DDEE1@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200805292102.17387.jbarnes@virtuousgeek.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday, May 29, 2008 8:39 pm Benjamin Herrenschmidt wrote:
> When Greg "fixed" the sysfs usage of that driver a while back, he seem
> to have introduced a bug where the quotes are added around the name of
> our specific sysfs files, thus breaking the user space tool.
>
> This fixes it. Tested DLPAR operations on a POWER6 machine successfully.

Do you think this is important enough for 2.6.26?

Thanks,
Jesse
