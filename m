Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0D1B67A86
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 05:58:02 +1100 (EST)
Date: Thu, 27 Jan 2005 19:57:30 +0100
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050127195730.07d3b4e9@jack.colino.net>
In-Reply-To: <1106012932.4533.46.camel@gaston>
References: <1106012932.4533.46.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH] radeonfb: massive update of PM code
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 18 Jan 2005 at 12h01, Benjamin Herrenschmidt wrote:

Hi, 

> +module_param(default_dynclk, int, -2);

Btw, I have been told that module_param()'s third parameters is an octal
used for permissions (as 0644).

-- 
Colin
  Reality continues to ruin my life.
		-- Calvin
