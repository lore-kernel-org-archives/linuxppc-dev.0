Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18149.52956.875510.937857@cargo.ozlabs.ibm.com>
Date: Tue, 11 Sep 2007 09:10:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] export new __io{re,un}map_at() symbols
In-Reply-To: <20070910224136.GA28808@lixom.net>
References: <20070831035851.GA24414@lixom.net>
	<18149.48608.754709.782967@cargo.ozlabs.ibm.com>
	<20070910224136.GA28808@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> electra_cf uses it, that driver is currently in -mm including below
> update to use benh's rewritten interfaces:
> 
> http://patchwork.ozlabs.org/linuxppc/patch?id=13237
> 
> It gets the effective addresses to use out of the device tree.

Huh?  What does firmware (or the device tree) know about how the
kernel uses effective addresses?

Paul.
