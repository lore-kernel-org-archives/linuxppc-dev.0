Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.15])
	by bilbo.ozlabs.org (Postfix) with ESMTP id E4733B7BA9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 03:54:20 +1000 (EST)
Message-ID: <4A94251A.9030102@am.sony.com>
Date: Tue, 25 Aug 2009 10:53:30 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [patch] powerpc/ps3: Update ps3_defconfig
References: <4A93347C.4060609@am.sony.com> <21549.1251177643@neuling.org>
In-Reply-To: <21549.1251177643@neuling.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/24/2009 10:20 PM, Michael Neuling wrote:
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>> ---
>> Hi Ben,
>> 
>> Please send upstream if it is not too late.
> 
> Is the current one broken?  Maybe a commit message would be nice :-P

The current one is fine.  The main change are:

 o Refresh for 2.6.31.
 o Remove MTD support.
 o Add more HID drivers.

-Geoff
