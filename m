Return-Path: <richardcochran@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by ozlabs.org (Postfix) with ESMTP id 8A711B6F05
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 15:49:25 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so13146fgg.3
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 22:49:22 -0700 (PDT)
Date: Wed, 30 Jun 2010 08:49:26 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: CONFIG_NO_HZ causing poor console responsiveness
Message-ID: <20100630064926.GA3792@riccoc20.at.omicron.at>
References: <AANLkTilMzfwgYvoFhxhcVQVGV-EkMLVHI2TeQ29SYFCH@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTilMzfwgYvoFhxhcVQVGV-EkMLVHI2TeQ29SYFCH@mail.gmail.com>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 29, 2010 at 02:54:17PM -0500, Timur Tabi wrote:
> I'm adding support for a new e500-based board (the P1022DS), and in
> the process I've discovered that enabling CONFIG_NO_HZ (Tickless
> System / Dynamic Ticks) causes significant responsiveness problems on
> the serial console.  When I type on the console, I see delays of up to
> a half-second for almost every character.  It acts as if there's a
> background process eating all the CPU.
> 
> I don't have time to debug this thoroughly at the moment.  The problem
> occurs in the latest kernel, but it appears not to occur in 2.6.32.
> 
> Has anyone else seen anything like this?

Yes, with a P2020RDB and kernel 2.6.35-rc1. Serial console is really
slow on an otherwise idle machine. I assumed it was a hardware
problem.

Richard
