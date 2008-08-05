Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 7A379DDE1B
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 07:08:12 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so495131anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Aug 2008 14:08:11 -0700 (PDT)
Message-ID: <fa686aa40808051408j34dedabg760c68480ead0f24@mail.gmail.com>
Date: Tue, 5 Aug 2008 15:08:11 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH add immr alias 1/4] powerpc: Teach get_immrbase to use
	immr alias if it exists.
In-Reply-To: <4898BCD3.5050703@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
	<200808052243.24001.arnd@arndb.de> <4898BCD3.5050703@freescale.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	John Rigby <jrigby@freescale.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 5, 2008 at 2:49 PM, Scott Wood <scottwood@freescale.com> wrote:
> Arnd Bergmann wrote:
>>
>> On Tuesday 05 August 2008, John Rigby wrote:
>>>
>>> This will allow the eventual removal of device_type = "soc"
>>> properties in soc nodes.
>>
>> Stupid question, but why not remove immrbase instead?
>>
>> It seems that all users can be converted to use a reg
>> property of some actual device instead of making assumptions
>> about the register layout of the whole SOC.
>
> That wouldn't eliminate the need for the alias, though -- u-boot needs to
> find the node to fill in properties.

(already made this comment on one of the later patches, but it is more
relevant here...)

I don't think that using aliases is the best solution.  I'd rather see
U-Boot search for the appropriate compatible value for the IMMR node.

g.

>
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
