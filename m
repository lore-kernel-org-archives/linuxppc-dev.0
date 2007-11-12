Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18232.56988.723620.912943@cargo.ozlabs.ibm.com>
Date: Tue, 13 Nov 2007 10:15:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] PMU: replace information ioctls and schedule for removal
In-Reply-To: <1194885218.5229.47.camel@johannes.berg>
References: <1194523351.6294.11.camel@johannes.berg>
	<1194814546.6510.20.camel@pasglop>
	<1194885218.5229.47.camel@johannes.berg>
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

> Does anybody need that? I'm not against adding it but we never showed it
> and I haven't seen anyone ask for it.

pmud uses the PMU version, but I think it gets it by issuing a PMU
command.

Paul.
