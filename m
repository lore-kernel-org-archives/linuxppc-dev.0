Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17985.27655.143391.338024@cargo.ozlabs.ibm.com>
Date: Wed, 9 May 2007 16:36:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] swsusp: introduce register_nosave_region_late
In-Reply-To: <17985.26509.807018.401277@cargo.ozlabs.ibm.com>
References: <1178616229.18162.40.camel@johannes.berg>
	<17985.26509.807018.401277@cargo.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras writes:

> OK, but the patch doesn't apply against Linus' tree.  It has no
> mention of register_nosave_region in include/linux/suspend.h, for
> instance.  Which tree is this patch against?

Sorry, ignore this, I had the wrong branch checked out.

Paul.
