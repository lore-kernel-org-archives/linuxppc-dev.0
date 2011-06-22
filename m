Return-Path: <paulus@ozlabs.org>
Date: Wed, 22 Jun 2011 13:20:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 0/15] Hypervisor-mode KVM on POWER7 and PPC970
Message-ID: <20110622032013.GA28610@bloggs.ozlabs.ibm.com>
References: <20110618082705.GA28413__14973.6630417921$1308385948$gmane$org@bloggs.ozlabs.ibm.com>
	<itq97v$dc$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <itq97v$dc$1@dough.gmane.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 21, 2011 at 02:18:39PM +0000, Dmitry Eremin-Solenikov wrote:

> I have a Maple board (dual PPC970FX). Will this patchset work on it?
> Should I add any additional changes to add support for this platform?

Provided the firmware gives you control in hypervisor mode, yes it
should work, and I don't know of any extra changes you would need.
I don't recall what firmware the Maple boards had on them, though.

Paul.
