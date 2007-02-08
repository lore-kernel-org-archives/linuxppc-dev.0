Return-Path: <scottwood@freescale.com>
Message-ID: <45CB5A78.10103@freescale.com>
Date: Thu, 08 Feb 2007 11:14:32 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 11/19] bootwrapper: Add ft_find_device_rel().
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230133.GK3849@ld0162-tx32.am.freescale.net>
	<20070208011147.GC31321@localhost.localdomain>
In-Reply-To: <20070208011147.GC31321@localhost.localdomain>
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
> On Wed, Feb 07, 2007 at 05:01:33PM -0600, Scott Wood wrote:
> 
>>Add a function to look up a relative, rather than absolute, path
>>name.
> 
> 
> Why do you need this one?

It's used in set_clocks() in cuboot.c.

-Scott
