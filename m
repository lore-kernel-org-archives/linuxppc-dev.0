Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17827.18627.560100.376047@cargo.ozlabs.ibm.com>
Date: Tue, 9 Jan 2007 18:48:19 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: 2.6.20-rc4 Kernel Oops on Maple
In-Reply-To: <1168326195.14763.312.camel@shinybook.infradead.org>
References: <1168289034.2610.214.camel@darkside.terraplex.com>
	<20070108210417.GA8122@localdomain>
	<1168326195.14763.312.camel@shinybook.infradead.org>
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> > http://patchwork.ozlabs.org/linuxppc/patch?id=8840
> 
> ... which triggers a WARN_ON() which is _supposed_ to be otherwise
> harmless. Unfortunately due to another bug in BUG() handling, the
> warning actually kills the machine instead of just bitching a bit:
> http://patchwork.ozlabs.org/linuxppc/patch?id=8811

Both of those are in my queue to go to Linus very soon.

Paul.
