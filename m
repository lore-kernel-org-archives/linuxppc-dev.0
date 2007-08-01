Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18096.6654.934841.561238@cargo.ozlabs.ibm.com>
Date: Wed, 1 Aug 2007 15:28:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] fixes for the SLB shadow buffer
In-Reply-To: <17055.1185944172@neuling.org>
References: <17055.1185944172@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling writes:

> +		slb_shadow_update(mk_esid_data(VMALLOC_START, 1),
> +				  mk_vsid_data(VMALLOC_START, vflags), 1);

Could you re-jig slb_shadow_update to take ea, slot and vflags, and
call mk_[ev]sid_data itself, rather than exposing mk_esid_data and
mk_vsid_data, please?

Paul.
