Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 82E6BDDE28
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 15:34:25 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so295442anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 21:34:21 -0700 (PDT)
Message-ID: <fa686aa40803202134p7db6a106n8487aa0040b5990c@mail.gmail.com>
Date: Thu, 20 Mar 2008 22:34:21 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sean MacLennan" <smaclennan@pikatech.com>
Subject: Re: DTS question
In-Reply-To: <20080321001236.4e37bba4@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080320173302.7075a1d9@lappy.seanm.ca>
	<20080320181926.2ff7e297@lappy.seanm.ca>
	<47E2E4A2.9000801@freescale.com>
	<20080321001236.4e37bba4@lappy.seanm.ca>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2008 at 10:12 PM, Sean MacLennan
<smaclennan@pikatech.com> wrote:
> On Thu, 20 Mar 2008 17:26:42 -0500
>  "Scott Wood" <scottwood@freescale.com> wrote:
>
>  > >     ad7414 {
>  > >             compatible = "ad7414";
>  >
>  > This should proabably have a manufacturer prefix.
>
>  I wondered about this. Since the AD from Analog Devices is built into
>  the part number, I didn't know if it was needed. And analog-devices is
>  pretty long ;)
>
>  But I am willing to put it in if it is necessary.

Convention is to use the stock ticker symbol.  If the company is
private and has no stock ticker symbol, then the company name should
be used.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
