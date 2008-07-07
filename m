Return-Path: <gerickson@nuovations.com>
Received: from relay03.pair.com (relay03.pair.com [209.68.5.17])
	by ozlabs.org (Postfix) with SMTP id A3DD4DDEFF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:02:37 +1000 (EST)
Date: Mon, 07 Jul 2008 15:02:22 -0700
Subject: Re: [PATCH v5] ibm_newemac: Parameterize EMAC Multicast Match Handling
From: Grant Erickson <gerickson@nuovations.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Message-ID: <C497E07E.104C7%gerickson@nuovations.com>
In-Reply-To: <48727374.1010304@ru.mvista.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/7/08 12:50 PM, Valentine Barshak wrote:
> Grant Erickson wrote:
> 
> <snip>
> 
>> -    reg = <ef600a00 70>;
>> +    reg = <ef600900 c4>;
> 
> Should be reg = <ef600a00 c4>
> 
> <snip>
> 
>> -    reg = <ef600a00 70>;
>> +    reg = <ef600900 c4>;
> 
> Should be reg = <ef600a00 c4>

Good catch; amended patch forthcoming.

Regards,

Grant
