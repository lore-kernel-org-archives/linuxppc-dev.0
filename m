Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 63721DE652
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 07:13:11 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <m34p44cbpz.wl%vmayatsk@redhat.com>
References: <m34p44cbpz.wl%vmayatsk@redhat.com>
To: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Subject: Re: take in count O_NONBLOCK flag for rtas log
Date: Thu, 25 Sep 2008 22:13:05 +0100
Message-ID: <1545.1222377185@redhat.com>
Sender: dhowells@redhat.com
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Mayatskikh <v.mayatskih@gmail.com> wrote:

> +		if (!logging_enabled) {
> +			spin_unlock_irqrestore(&rtasd_log_lock, s);
> +			error = -ENODATA;
> +			goto out;
> +		} else
> +			nvram_clear_error_log();

The 'else' here is unnecessary.  It's preceded inside the curlies by a goto.

David
