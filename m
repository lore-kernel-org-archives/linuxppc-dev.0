Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 65105DDE34
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 07:00:55 +1000 (EST)
Message-ID: <46671DED.5040709@am.sony.com>
Date: Wed, 06 Jun 2007 13:49:49 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [patch 02/18] PS3: Rename IPI symbols
References: <20070606024407.786638029@am.sony.com>	<4666230D.4020902@am.sony.com>
	<20070606131157.133ce9bb.sfr@canb.auug.org.au>
In-Reply-To: <20070606131157.133ce9bb.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> On Tue, 05 Jun 2007 19:59:25 -0700 Geoff Levand <geoffrey.levand@am.sony.com> wrote:
>>
>> Rename the PS3 static symbol virqs to ps3_ipi_virqs to aid in
>> debugging.
>> 
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>>
>>  	for (i = 0; i < MSG_COUNT; i++) {
>> -		free_irq(virqs[i], (void*)(long)i);
>> +		/* Can't call free_irq from interrupt context. */
> 
> This change is probably worth a mention in the change log - it looks like
> a bug fix.

That leaked into this patch from my kexec cleanups.  I'll move it out
to where it belongs.

-Geoff
