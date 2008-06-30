Return-Path: <jcrigby@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id DC93CDDED6
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 13:59:50 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1056834rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 20:59:49 -0700 (PDT)
Message-ID: <4b73d43f0806292059y2a2b4642g5e8303ff13728c30@mail.gmail.com>
Date: Sun, 29 Jun 2008 21:59:49 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/6] MPC5121 Add PCI support
In-Reply-To: <20080629053844.GD13876@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1213981119-1979-1-git-send-email-jrigby@freescale.com>
	<1213981119-1979-2-git-send-email-jrigby@freescale.com>
	<1213981119-1979-3-git-send-email-jrigby@freescale.com>
	<1213981119-1979-4-git-send-email-jrigby@freescale.com>
	<1213981119-1979-5-git-send-email-jrigby@freescale.com>
	<1213981119-1979-6-git-send-email-jrigby@freescale.com>
	<20080629053844.GD13876@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes, Kumar made the same comment.  The newer patch that moves the 83xx
add bridge routine to fsl_soc obsoletes this patch.

On Sat, Jun 28, 2008 at 11:38 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Fri, Jun 20, 2008 at 10:58:38AM -0600, John Rigby wrote:
>> Copied from 83xx minus support for two busses.
>
> If this is a copy, then can it be shared?
>
> g.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
