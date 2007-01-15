Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17834.60612.793025.590958@cargo.ozlabs.ibm.com>
Date: Mon, 15 Jan 2007 13:53:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Fix performance monitor exception in 2.6.20-series
In-Reply-To: <1168828808.9415.278.camel@shinybook.infradead.org>
References: <20070113154029.GA32292@eecg.toronto.edu>
	<1168734544.5011.78.camel@localhost.localdomain>
	<1168828808.9415.278.camel@shinybook.infradead.org>
Cc: Livio Soares <livio@eecg.toronto.edu>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> If we can _make_ it safe, and in doing so avoid the failure mode where
> the machine locks up with interrupts disabled and then the PMU resets
> itself entirely (including the date), that might be a good thing...

Different PMU, I think; they are talking about the Performance Monitor
Unit in POWERx cpus.

Paul.
