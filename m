Return-Path: <scottwood@freescale.com>
Message-ID: <45CCAB41.4080003@freescale.com>
Date: Fri, 09 Feb 2007 11:11:29 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 19/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230149.GS3849@ld0162-tx32.am.freescale.net>
	<20070208211529.GA1894@localhost.localdomain>
In-Reply-To: <20070208211529.GA1894@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Feb 07, 2007 at 05:01:49PM -0600, Scott Wood wrote:
> 
>>Add a bootwrapper platform (cuboot) that takes a bd_t from a legacy
>>U-Boot, and inserts data from it into a device tree which has been
>>compiled into the kernel.  This should help ease the transition to
>>arch/powerpc in cases where U-Boot has not yet been updated to pass a
>>device tree, or where upgrading firmware isn't practical.
>>
>>The device trees currently in the kernel tree must have
>>/chosen/linux,stdout-path added to work with cuboot.
>>
>>The kernel command line, mac addresses, and various clocks will be filled
>>in based on the bd_t.
> 
> 
> You're still using config dependent stuff in here...

They come from platform files such as cuboot-83xx.c, not (directly) from 
the kernel config.

-Scott
