Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by ozlabs.org (Postfix) with ESMTP id 6D4D0DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 May 2007 04:41:44 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id v1so281034nzb
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 May 2007 11:41:43 -0700 (PDT)
Message-ID: <fa686aa40705231141w15120170ke5e624d592abbd76@mail.gmail.com>
Date: Wed, 23 May 2007 12:41:42 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [PATCH] Fix mpc52xx_uart_of_assign to use correct index
In-Reply-To: <1179941455907-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1179941455907-git-send-email-jrigby@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/23/07, John Rigby <jrigby@freescale.com> wrote:
> Use idx as index into mpc52xx_uart_nodes instead of i
>
> Signed-off-by: John Rigby <jrigby@freescale.com>

Good catch

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
