Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id D7760DDE1B
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 17:05:59 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so81975anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 22:05:58 -0800 (PST)
Message-ID: <fa686aa40802212205p38c3793bg8793740955b1e91@mail.gmail.com>
Date: Thu, 21 Feb 2008 23:05:58 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH] Add support for binary includes.
In-Reply-To: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 20, 2008 at 12:19 PM, Scott Wood <scottwood@freescale.com> wrote:
> A property's data can be populated with a file's contents
>  as follows:
>
>  node {
>         prop = /incbin/("path/to/data");
>  };
>
>  A subset of a file can be included by passing start and size parameters.
>  For example, to include bytes 8 through 23:
>
>  node {
>         prop = /incbin/("path/to/data", 8, 16);
>  };


Can I ask; what is the intended usage of such a thing?  How large
would a typical binary blob be?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
