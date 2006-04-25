Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C64EB67A60
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 05:31:12 +1000 (EST)
Date: Tue, 25 Apr 2006 12:31:09 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Message-ID: <20060425193109.GE1132@gate.ebshome.net>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
	<248CD1B3-A33B-47F5-AFE8-F7C9DDCD1D0B@kernel.crashing.org>
	<20060425185314.GC1132@gate.ebshome.net>
	<01B6C49A-F82A-47CF-B7B8-106BC0BBDF14@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01B6C49A-F82A-47CF-B7B8-106BC0BBDF14@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 25, 2006 at 02:20:03PM -0500, Kumar Gala wrote:
> 
> On Apr 25, 2006, at 1:53 PM, Eugene Surovegin wrote:
> 
> >On Tue, Apr 25, 2006 at 01:33:38PM -0500, Kumar Gala wrote:
> >>I personally dont have any time or interesting in it.
> >
> >So, don't break compatibility if you don't have time/interest to fix
> >it. We can wait till someone who "wants to move forward" can do this
> >professionally without screwing everybody else.
> 
> If I break compatibility for boards I maintain I don't see the issue  
> as long as I provide a workable solution.

Sorry, but IMO saying you have to upgrade firmware is not a workable 
solution.

Firmware <-> kernel is external interface. Kernel shouldn't break it 
unless there is a good technical reason to do so. Developer 
convenience or lack of time is not a good technical reason in my book.

-- 
Eugene
