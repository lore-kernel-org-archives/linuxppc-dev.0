Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17880.61607.820418.760412@cargo.ozlabs.ibm.com>
Date: Mon, 19 Feb 2007 11:34:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [RFC 3/3] zImage: Exception vector support
In-Reply-To: <45D7A914.4040000@am.sony.com>
References: <45D7A914.4040000@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> +	xor	r4, r4, r4

What's wrong with "li r4,0"?

Paul.
