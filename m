Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BDF79DE0C4
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 05:44:27 +1000 (EST)
Message-Id: <AE9B4B27-F781-4C0B-9E17-79F3E7C78CF7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <771B1F79-194B-4C6A-A2AE-5E4BEF0A17D3@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/oprofile: dump_pmcs() is not used
Date: Tue, 7 Apr 2009 14:42:02 -0500
References: <95c5ebd63992c64ad0b644f1204362aaf5e35eeb.1239025478.git.michael@ellerman.id.au>
	<771B1F79-194B-4C6A-A2AE-5E4BEF0A17D3@freescale.com>
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 6, 2009, at 9:03 AM, Kumar Gala wrote:

>
> On Apr 6, 2009, at 8:45 AM, Michael Ellerman wrote:
>
>> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>> ---
>> arch/powerpc/oprofile/op_model_fsl_emb.c |    2 ++
>> 1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> Or should we just remove it?
>
> I'm for removing it if Andy doesn't have any issues.  Someone can  
> always add it back as debugfs code in the future if they want it.

I chatted w/Andy and we both agreed to just remove the code rather  
than #if 0 it.  If you send me a patch with that I'll apply it.

- k
