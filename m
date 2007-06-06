Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CAE6CDDEE3
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 06:48:04 +1000 (EST)
Message-ID: <46671D7E.7010907@am.sony.com>
Date: Wed, 06 Jun 2007 13:47:58 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: will_schmidt@vnet.ibm.com
Subject: Re: [patch 02/18] PS3: Rename IPI symbols
References: <20070606024407.786638029@am.sony.com>	
	<4666230D.4020902@am.sony.com>	
	<20070606131157.133ce9bb.sfr@canb.auug.org.au>
	<1181141312.18837.6.camel@farscape.rchland.ibm.com>
In-Reply-To: <1181141312.18837.6.camel@farscape.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Will Schmidt wrote:
> On Wed, 2007-06-06 at 13:11 +1000, Stephen Rothwell wrote:
>> On Tue, 05 Jun 2007 19:59:25 -0700 Geoff Levand <geoffrey.levand@am.sony.com> wrote:
>> >
>> > Rename the PS3 static symbol virqs to ps3_ipi_virqs to aid in
>> > debugging.
>> > 
>> > Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>> >
>> >  	for (i = 0; i < MSG_COUNT; i++) {
>> > -		free_irq(virqs[i], (void*)(long)i);
>> > +		/* Can't call free_irq from interrupt context. */
>> 
>> This change is probably worth a mention in the change log - it looks like
>> a bug fix.
> 
> 
> Does the free_irq call (being removed here) need to be added back in
> somewhere else? 

No, the kernel is kexecing, so it is not needed.

-Geoff
