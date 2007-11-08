Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18226.29858.616818.855736@cargo.ozlabs.ibm.com>
Date: Thu, 8 Nov 2007 13:29:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH (2.6.25) 1/2] hibernation: clean up Kconfig
In-Reply-To: <20071107135848.417344000@sipsolutions.net>
References: <20071107135758.100171000@sipsolutions.net>
	<20071107135848.417344000@sipsolutions.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@ozlabs.org,
	linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> This cleans up the hibernation Kconfig and removes the need to
> declare centrally which architectures support hibernation. All
> architectures that currently support hibernation are modified
> accordingly.

Acked-by: Paul Mackerras <paulus@samba.org>
