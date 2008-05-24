Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 80907DE07D
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 16:43:59 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so243096anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 23:43:58 -0700 (PDT)
Message-ID: <fa686aa40805232343x20031560j5659d203e25f494@mail.gmail.com>
Date: Sat, 24 May 2008 00:43:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [PATCH 2/4] spi: split up spi_new_device() to allow two stage
	registration.
In-Reply-To: <200805211717.13206.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193608.28030.34968.stgit@trillian.secretlab.ca>
	<200805211717.13206.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, fabrizio.garetto@gmail.com,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 6:17 PM, David Brownell <david-b@pacbell.net> wrote:
> On Friday 16 May 2008, Grant Likely wrote:
>>
>> This patch splits the allocation and registration portions of code out
>> of spi_new_device() and creates three new functions; spi_alloc_device(),
>> spi_register_device(), and spi_device_release().
>
> I have no problem with the first two, but why the last?
>
> If the devices are always allocated by spi_alloc_device() as
> they should be -- probably through an intermediary -- the
> only public function necessary for that cleanup should be
> the existing spi_dev_put().

Ah, okay.  I'm still a bit fuzzy on the device model conventions.
I'll remove that then.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
