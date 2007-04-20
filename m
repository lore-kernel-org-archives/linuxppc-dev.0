Return-Path: <tur@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [62.233.211.107])
	by ozlabs.org (Postfix) with ESMTP id 83434DDE41
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 23:53:39 +1000 (EST)
Message-ID: <4628BFE4.2090801@semihalf.com>
Date: Fri, 20 Apr 2007 15:28:04 +0200
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Don't shutdown TX on mpc5200 serial port if it is a
	console
References: <11770117743675-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11770117743675-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> If the serial port gets shut down, then console output stalls.  9 out
> of 10 kernel hackers agree, this is a bad thing.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> Wolfgang, please verify this new patch.  Sylvain rightly pointed out that
> RX and interrupts should be turned off regardless.  If it works for you,
> please reply with a Signed-of-by line.

Patch verified on a MPC5200B-based board.

Signed-off-by: Bartlomiej Sieka <tur@semihalf.com>


Regards,
Bartlomiej
