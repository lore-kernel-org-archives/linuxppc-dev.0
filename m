Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 1EE5FDDF23
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 16:47:29 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1647589wag
	for <linuxppc-dev@ozlabs.org>; Sun, 07 Oct 2007 23:47:23 -0700 (PDT)
Message-ID: <fa686aa40710072347g7e084169xcd4af905ab6f2ea9@mail.gmail.com>
Date: Mon, 8 Oct 2007 00:47:23 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH 10/15] [POWERPC] Add mpc52xx_find_and_map_path(),
	refactor utility functions.
In-Reply-To: <4708C343.30104@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47075FA7.3030108@semihalf.com> <4708C343.30104@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/7/07, Marian Balakowicz <m8@semihalf.com> wrote:
>
> Add helper routine mpc52xx_find_and_map_path(). Extract common code to
> mpc52xx_map_node() and refactor mpc52xx_find_and_map().
>
> Signed-off-by: Jan Wrobel <wrr@semihalf.com>

Looks good to me.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
