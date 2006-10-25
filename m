Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17726.63354.839675.689493@cargo.ozlabs.ibm.com>
Date: Wed, 25 Oct 2006 15:34:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: Crash with highmem support enabled
In-Reply-To: <20061023185714.22630@gmx.net>
References: <20060628202753.198630@gmx.net> <s5hfyhopb0s.wl%tiwai@suse.de>
	<20060629211513.64980@gmx.net> <s5hwtaz9fdr.wl%tiwai@suse.de>
	<20060630182144.27980@gmx.net> <20061019132423.270440@gmx.net>
	<1161474692.10524.266.camel@localhost.localdomain>
	<20061023185714.22630@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gerhard Pircher writes:

> I guess this has something to do with the IO block mapping, which is
> implemented in the amigaone_setup.c file and looks like this:

Why on earth are you still using io_block_mapping?

Paul.
