Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 29C9FDEC8F
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 05:34:06 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1166276anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 12:34:05 -0700 (PDT)
Message-ID: <fa686aa40807251234n74e4cd75yd6313fa394533625@mail.gmail.com>
Date: Fri, 25 Jul 2008 15:34:03 -0400
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [PATCH v3 2/4] spi: split up spi_new_device() to allow two stage
	registration.
In-Reply-To: <200807251200.45321.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
	<20080725073316.8485.84001.stgit@trillian.secretlab.ca>
	<200807251200.45321.david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 25, 2008 at 3:00 PM, David Brownell <david-b@pacbell.net> wrote:
> On Friday 25 July 2008, Grant Likely wrote:
>>
>> This change is in preparation for adding an OF device tree parser to
>> generate spi_devices based on data in the device tree.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> Given the comment fixes noted above and below:
>
>
> Acked-by: David Brownell <dbrownell@users.sourceforge.net>

Cool, I'll get all this fixed.  Thanks.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
