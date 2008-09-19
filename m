Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id E5E3ADE15B
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 02:43:44 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so469413rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 09:43:43 -0700 (PDT)
Date: Fri, 19 Sep 2008 10:43:42 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: sebastien.chretien.enseirb@gmail.com
Subject: Re: ioremap and vmalloc
Message-ID: <20080919164342.GA8723@secretlab.ca>
References: <319b0ac50809190415g6d132058l9bb8521046502eab@mail.gmail.com>
	<20080919134933.GA7849@secretlab.ca> <48D3D47E.5050200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48D3D47E.5050200@gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 19, 2008 at 06:34:06PM +0200, =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien_ wrote:
> The first is ioremap(0x20000000,0x10000000);
> The second is ioremap(0x80000000,0x10000000);
> Is it too long

Well, you're trying to allocate two 256MB regions.  That is very large.
What kind of device are you trying to map?

g.
