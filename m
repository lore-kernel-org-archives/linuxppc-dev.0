Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 27820DDF2F
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 15:50:46 +1000 (EST)
Message-Id: <92D6E129-1819-4E7B-ABA0-50B8FD7079CE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: ananth@in.ibm.com
In-Reply-To: <20080603054846.GC31747@in.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [RFC] Kprobes for book-e
Date: Tue, 3 Jun 2008 00:50:06 -0500
References: <Pine.LNX.4.64.0806030027340.27857@blarg.am.freescale.net>
	<20080603054846.GC31747@in.ibm.com>
Cc: madhvesh.s@ap.sony.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, rsmadhvesh@vsnl.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 3, 2008, at 12:48 AM, Ananth N Mavinakayanahalli wrote:

> On Tue, Jun 03, 2008 at 12:30:51AM -0500, Kumar Gala wrote:
>> This is a patch that adds kprobes support for book-e style debug.   
>> Its
>> based on the patch posted by Madhvesh and assumes the exception  
>> cleanup
>> that I've already posted.
>>
>> Post to get any feedback.  The code needs some cleaning up but  
>> wanted to
>> see if there were any initial comments.
>>
>> - k
>
> ...
>
>> @@ -53,7 +68,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>> 		ret = -EINVAL;
>> 	}
>>
>> -	/* insn must be on a special executable page on ppc64 */
>> +	/* insn must be on a special executable page on ppc64.  This is
>> +	 * explicitly required on ppc32 (right now), but it doesn't hurt */
> 	^^^^^^^^
> 	not required?

yes.  that should be 'not required'..

> I don't have much (any) knowledge about Book-E details, but the  
> generic
> powerpc changes look fine to me.

- k
