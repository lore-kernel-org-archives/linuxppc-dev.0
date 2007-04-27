Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17969.36930.988443.16462@cargo.ozlabs.ibm.com>
Date: Fri, 27 Apr 2007 15:55:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 2/13] powerpc: Add dt_xlate_addr() to bootwrapper
In-Reply-To: <20070425235543.GD4046@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235543.GD4046@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer writes:

> dt_xlate_reg() looks up the 'reg' property in the specified node
> to get the address and size to translate.  Add dt_xlate_addr()
> which is passed in the address and size to translate.

Could you rebase on top of Scott Wood's patch fixing bugs in
dt_xlate_reg please?

Paul.
