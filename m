Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 9C9B0DDF30
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2007 10:49:28 +1100 (EST)
Date: Thu, 1 Mar 2007 16:49:51 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: RFA & Update: Using libfdt in u-boot for fdt command
Message-ID: <20070301234951.GC8177@mag.az.mvista.com>
References: <45E6DCB4.3080106@smiths-aerospace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45E6DCB4.3080106@smiths-aerospace.com>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 01, 2007 at 09:01:24AM -0500, Jerry Van Baren wrote:
> Hi all,
> 
> This is a Request for Advice.

Hi Jerry.

One minor thing.  I'd just want to remind you that we shouldn't stray
too far from the OF interface.  The bootwrapper code sits on top of
either the FDT access interface or the true OF DT access interface.  
The closer we keep the two, the cleaner & easier the we can keep
the bootwrapper code.

Mark
