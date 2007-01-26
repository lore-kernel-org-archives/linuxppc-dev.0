Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17850.33057.686491.685870@cargo.ozlabs.ibm.com>
Date: Sat, 27 Jan 2007 09:30:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH] pSeries: EEH improperly enabled for some Power4 systems
In-Reply-To: <20070126205503.GA11220@austin.ibm.com>
References: <20070126205503.GA11220@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas writes:

> It appears that EEH is improperly enabled for some Power4 systems.
> On these systems, the ibm,set-eeh-option returns a value of success
> even when EEH is not supported on the given node. Thus, an explicit
> check for support is required.

What happens on the power4 systems when EEH is improperly enabled?

What systems has the patch been tested on?

Thanks,
Paul.
