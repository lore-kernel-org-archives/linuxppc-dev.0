Return-Path: <jcrigby@gmail.com>
Received: from wx-out-0102.google.com (wx-out-0102.google.com [66.249.82.203])
	by ozlabs.org (Postfix) with ESMTP id 58F4D679E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 06:04:22 +1000 (EST)
Received: by wx-out-0102.google.com with SMTP id s11so8414wxc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 13:04:21 -0700 (PDT)
Message-ID: <4b73d43f0605101258x134646b8ufd323cff57cbd65d@mail.gmail.com>
Date: Wed, 10 May 2006 13:58:01 -0600
From: "John Rigby" <jrigby@freescale.com>
Sender: jcrigby@gmail.com
To: "Dan Malek" <dan@embeddedalley.com>
Subject: Re: IMAP_ADDR on PPC 8xx
In-Reply-To: <6CE25E1C-0F7A-4644-926E-746C17A7A851@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4D8794260B62C940BBA7150CC5EB3BD43D23CA@bosmail.BOS.int.mrv.com>
	<1147204345.3139.11.camel@excalibur.timesys.com>
	<3A4FA660-AD13-4E2B-846B-B9ACD901444F@embeddedalley.com>
	<1147274635.23931.17.camel@excalibur.timesys.com>
	<1147279763.23931.32.camel@excalibur.timesys.com>
	<6CE25E1C-0F7A-4644-926E-746C17A7A851@embeddedalley.com>
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

Thanks Dan for the extra info.

Just to let everyone know even though this turned out to not
be our problem we here at Freescale are looking at how we
can make sure this does not happen in the future.  We want
any uboot shipped with future Freescale boards to have the
correct behavior.  We also understand the board documentation
needs to be changed to mention the appropriate value for IMMR
for linux.

John
jrigby@freescale.com

On 5/10/06, Dan Malek <dan@embeddedalley.com> wrote:
>
> On May 10, 2006, at 12:49 PM, Walter L. Wimer III wrote:
>
> > FYI, here's a table from the "MPC885ADS PowerQUICC(tm) Application
> > Development System User's Guide", available on Freescale's website.
> > This table seems to confirm how they've configured their U-Boot -- the
> > IMMR is set to 0x02200000...
>
> Freescale never ported U-Boot to the MPC855ADS platform, and
> I don't believe it came with any software at all.  This IMMR value was
> chosen to be backward compatible with some old software tools to
> get a compact address space without the need of using the MMU,
> long before we had Linux running on the platform.
>
> > This may be fine for non-Linux purposes, but it looks like we need to
> > spread some gospel to Freescale regarding the correct IMMR address for
> > U-Boot / Linux....
>
> I think you better be pointing fingers at the clueless person that
> provided the software you have, as it didn't come from Freescale nor
> any of the public U-Boot sources.
>
> Thanks.
>
>         -- Dan
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
