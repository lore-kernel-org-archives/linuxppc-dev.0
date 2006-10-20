Return-Path: <mel@csn.ul.ie>
Received: from calculon.skynet.ie (calculon.skynet.ie [193.1.99.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95CC067BD9
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 02:31:04 +1000 (EST)
Date: Fri, 20 Oct 2006 17:30:58 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] Reintroduce NODES_SPAN_OTHER_NODES for powerpc
In-Reply-To: <8a76dfd735e544016c5f04c98617b87d@pinky>
Message-ID: <Pine.LNX.4.64.0610201730420.13216@skynet.skynet.ie>
References: <4538DACC.5050605@shadowen.org>
	<8a76dfd735e544016c5f04c98617b87d@pinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Oct 2006, Andy Whitcroft wrote:

> Reintroduce NODES_SPAN_OTHER_NODES for powerpc
>
> Revert "[PATCH] Remove SPAN_OTHER_NODES config definition"
>    This reverts commit f62859bb6871c5e4a8e591c60befc8caaf54db8c.
> Revert "[PATCH] mm: remove arch independent NODES_SPAN_OTHER_NODES"
>    This reverts commit a94b3ab7eab4edcc9b2cb474b188f774c331adf7.
>
> Also update the comments to indicate that this is still required
> and where its used.
>
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>

Acked-by: Mel Gorman <mel@csn.ul.ie>
