Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id A15DEDE0C2
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 07:13:01 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so495509anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Aug 2008 14:13:00 -0700 (PDT)
Message-ID: <fa686aa40808051412od699a57x59079bc59fb7150@mail.gmail.com>
Date: Tue, 5 Aug 2008 15:12:59 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH add immr alias 2/4] powerpc: 5121: Add immr alias to
	MPC5121 ADS device tree.
In-Reply-To: <4898C15E.3000900@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
	<1217967220-30557-2-git-send-email-jrigby@freescale.com>
	<fa686aa40808051405j7268c216j8e5b526d6ad526c9@mail.gmail.com>
	<4898C15E.3000900@freescale.com>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 5, 2008 at 3:08 PM, Scott Wood <scottwood@freescale.com> wrote:
> Grant Likely wrote:
>>
>> Is it not sufficient to search the tree for a node with the
>> <chip>-immr compatible value?  I don't think this is the intended use
>> case of aliases.
>
> That get's really annoying in code that is meant to deal with multiple
> chips.  I don't think finding the network or serial node that corresponds to
> u-boot's enumeration is what it's meant for, either, but pretty much any
> alternative you can come up with has someone saying that it's not what
> *that* was meant for, either.

But finding nodes that meet a criteria *is* what compatible is for and
there is precedence for it.  All u-boot platforms are finding the node
by path right now, and so all of them need to be changed.  Changing
them to find by compatible that is set per-board or per-SoC makes
complete sense to me.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
