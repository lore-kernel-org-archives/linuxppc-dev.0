Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 26EEADDE44
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 01:02:27 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id d23so190522and
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 08:02:26 -0700 (PDT)
Message-ID: <fa686aa40710170802t442f549ck5f7b94c19955f56b@mail.gmail.com>
Date: Wed, 17 Oct 2007 09:02:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH 1/4] [POWERPC] Add mpc52xx_find_and_map_path(),
	refactor utility functions
In-Reply-To: <47160709.5020002@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47160689.4020301@semihalf.com> <47160709.5020002@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/17/07, Marian Balakowicz <m8@semihalf.com> wrote:
>
> Add helper routine mpc52xx_find_and_map_path(). Extract common code to
> mpc52xx_map_node() and refactor mpc52xx_find_and_map().
>
> Signed-off-by: Jan Wrobel <wrr@semihalf.com>
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

Yeah, this is probably okay.  Eventually these util functions should
be refactored to be usable by any platform.

Cheers,
g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
