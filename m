Return-Path: <albert_herranz@yahoo.es>
Received: from smtp146.mail.ukl.yahoo.com (smtp146.mail.ukl.yahoo.com
	[77.238.184.77]) by ozlabs.org (Postfix) with SMTP id B7703B7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 07:16:56 +1100 (EST)
Message-ID: <4B0AEDB6.6040406@yahoo.es>
Date: Mon, 23 Nov 2009 21:16:54 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 15/19] powerpc: broadway processor support
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221538s46a81acal9b451bf48873b6be@mail.gmail.com>
In-Reply-To: <fa686aa40911221538s46a81acal9b451bf48873b6be@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> wrote:
>> This patch extends the cputable entry of the 750CL to also match
>> the 750CL-based "Broadway" cpu found on the Nintendo Wii.
>>
>> As of this patch, the following "Broadway" design revision levels have
>> been seen in the wild:
>> - DD1.2 (87102)
>> - DD2.0 (87200)
> 
> Please respin without the reordering of CPU table entries.  If you
> want to reorder, then do it in a separate patch.
> 
> g.
> 

Ok. I'll look into that too. Thanks.

Cheers,
Albert
