Return-Path: <James.Hogan@imgtec.com>
Received: from multi.imgtec.com (multi.imgtec.com [194.200.65.239])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "*.imgtec.com",
 Issuer "DigiCert High Assurance CA-3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4071D2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 20:49:25 +1100 (EST)
Message-ID: <514AD76D.2020401@imgtec.com>
Date: Thu, 21 Mar 2013 09:48:29 +0000
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] memblock: kill "config MAX_ACTIVE_REGIONS"
References: <1363858076.1390.104.camel@x61.thuisdomein>
 <20130321093455.GA8027@linux-sh.org>
In-Reply-To: <20130321093455.GA8027@linux-sh.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>,
 Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21/03/13 09:34, Paul Mundt wrote:
> On Thu, Mar 21, 2013 at 10:27:56AM +0100, Paul Bolle wrote:
>> The Kconfig symbol MAX_ACTIVE_REGIONS is unused. Commit
>> 0ee332c1451869963626bf9cac88f165a90990e1 ("memblock: Kill
>> early_node_map[]") removed the only place were it was actually used. But
>> it did not remove its Kconfig entries (for powerpc and sh).
>>
>> Remove those two entries (and the entry for metag, that popped up in
>> v3.9-rc1).
>>
>> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
>> ---
>> 0) Eyeball tested again.
>>
>> 1) It felt silly to split this clean up patch into three patches. But if
>> the maintainers involved disagree I'm happy to split and resend it. 
>>
> Given that it's unused now it doesn't really matter how it gets applied,
> it looks fine to me.
> 
> Acked-by: Paul Mundt <lethal@linux-sh.org>
> 

Acked-by: James Hogan <james.hogan@imgtec.com>
