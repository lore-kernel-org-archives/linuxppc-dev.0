Return-Path: <rini@arvoo.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4C664B7150
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 01:11:59 +1000 (EST)
Received: from smtp1.euronet.nl (smtp1.euronet.nl [194.134.35.133])
	by ozlabs.org (Postfix) with ESMTP id D340CDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 01:11:58 +1000 (EST)
Message-ID: <4A311EB6.5060209@arvoo.nl>
Date: Thu, 11 Jun 2009 17:11:50 +0200
From: Rini van Zetten <rini@arvoo.nl>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][POWERPC] mpc83xx : allow SPI without cs.
References: <4A30CA1F.4000702@arvoo.nl>
	<7071E2AF-65ED-41C2-AFE7-06E9336619CB@kernel.crashing.org>
In-Reply-To: <7071E2AF-65ED-41C2-AFE7-06E9336619CB@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

excuse me for my ignorance, but which -mm tree do you mean and where can I find it.

Regards,
Rini

Kumar Gala schreef:
> 
> On Jun 11, 2009, at 4:10 AM, Rini van Zetten wrote:
> 
>> This patch adds the possibility to have a spi device without a cs.
>>
>> For example, the dts file should look something like this:
>>
>> spi-controller {
>>       gpios = <&pio1 1 0      /* cs0 */
>>                0              /* cs1, no GPIO */
>>                &pio2 2 0>;    /* cs2 */
>>
>>
>>
>> Signed-off-by: Rini van Zetten <rini@arvoo.nl>
>> ---
>> drivers/spi/spi_mpc83xx.c |   44 
>> +++++++++++++++++++++++---------------------
>> 1 files changed, 23 insertions(+), 21 deletions(-)
> 
> This patch needs to be respun against the -mm tree as a lot of other spi 
> patches are queued up there that will cause this patch to not merge 
> correctly.
> 
> - k

-- 
Rini van Zetten
Senior Software Engineer

-------------------------
ARVOO Engineering B.V.
Tasveld 13
3417 XS Montfoort
The Netherlands

E-mail : <mailto:rini@arvoo.com> Rini van Zetten

Web : www.arvoo.com
