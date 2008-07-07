Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.243])
	by ozlabs.org (Postfix) with ESMTP id 58BCBDE05B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 00:29:49 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so13161070agc.0
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 07:29:48 -0700 (PDT)
Message-ID: <fa686aa40807070729w524aa50xb1c762f13ba31da1@mail.gmail.com>
Date: Mon, 7 Jul 2008 08:29:47 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH] powerpc/bootwrapper: Allow user to specify additional
	default targets
In-Reply-To: <20080707100704.26f1630c@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080701175852.32575.39707.stgit@trillian.secretlab.ca>
	<fa686aa40807032351l631febe2h8d38a9eed1053b6b@mail.gmail.com>
	<20080707091818.72d584fe@zod.rchland.ibm.com>
	<fa686aa40807070634t6e9047d1k7d8ca2b443d1ae68@mail.gmail.com>
	<20080707100704.26f1630c@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 7, 2008 at 8:07 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> On Mon, 7 Jul 2008 07:34:23 -0600 Grant Likely wrote:
>> Specifically the case I'm thinking of is when a user of a Xilinx FPGA
>> drops a new .dts file into arch/powerpc/boot/dts (say
>> 'super-sexy-platform.dts').  However, instead of modifying the
>> Makefile or always typing 'make simpleImage.super-sexy-platform', then
>> can add 'simpleImage.super-sexy-platform' to their defconfig which I
>> can see being easier for someone to get their head around.
>
> Yeah, I thought about the Virtex case with the differing bitstreams
> after I sent out my original question.  For purposes like that, this
> seems like a great fit.  For truly discrete boards, I prefer discrete
> defconfigs.
>
> So overall I see value in the patch.  If nobody else has objections,
> then it's fine with me.

so.... can I have an ack?  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
