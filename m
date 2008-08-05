Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 59339DE01A
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 07:05:43 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so494943anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Aug 2008 14:05:42 -0700 (PDT)
Message-ID: <fa686aa40808051405j7ea96957t9242e007c93d8e74@mail.gmail.com>
Date: Tue, 5 Aug 2008 15:05:42 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [PATCH add immr alias 2/4] powerpc: 5121: Add immr alias to
	MPC5121 ADS device tree.
In-Reply-To: <fa686aa40808051405j7268c216j8e5b526d6ad526c9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
	<1217967220-30557-2-git-send-email-jrigby@freescale.com>
	<fa686aa40808051405j7268c216j8e5b526d6ad526c9@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Oops, forgot to add devicetree-discuss to the cc: list

g.

On Tue, Aug 5, 2008 at 3:05 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Tue, Aug 5, 2008 at 2:13 PM, John Rigby <jrigby@freescale.com> wrote:
>> So get_immrbase can function without a device_type = "soc"
>> property in the soc node.
>>
>> The "soc" node should really be named "immr"
>> because it does not include the entire soc, however
>> u-boot currently looks up this node by name for
>> a clock fixup so leave it "soc" for now.  We will change
>> it later after 5121 u-boot uses the immr alias instead
>> of the node name.
>
> Is it not sufficient to search the tree for a node with the
> <chip>-immr compatible value?  I don't think this is the intended use
> case of aliases.
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
