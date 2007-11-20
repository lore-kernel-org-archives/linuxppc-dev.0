Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18242.21895.876009.632187@cargo.ozlabs.ibm.com>
Date: Tue, 20 Nov 2007 14:33:27 +1100
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] PMU: replace information ioctls and schedule for
	removal
In-Reply-To: <1194981108.6695.11.camel@johannes.berg>
References: <1194981108.6695.11.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> This patch adds sysfs attributes to the PMU to allow getting
> the information on the PMU type and whether adb is present from
> there instead of via the ioctl. The ioctl is made optional and
> scheduled for removal.

I don't see any reason to ever remove the ioctls.  We're talking about
just 4 lines of code here.  Sure we can add the sysfs attributes -
even though that adds an order of magnitude more lines of code 
(thanks sysfs :) but I don't see any good reason to remove the
existing interface.

Paul.
