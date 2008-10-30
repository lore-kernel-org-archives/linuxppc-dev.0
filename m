Return-Path: <gerickson@nuovations.com>
Received: from relay02.pair.com (relay02.pair.com [209.68.5.16])
	by ozlabs.org (Postfix) with SMTP id BCEE6DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 01:33:56 +1100 (EST)
Date: Thu, 30 Oct 2008 07:33:25 -0700
Subject: Re: [PATCH] PPC40x: Limit Allocable RAM During Early Mapping
From: Grant Erickson <gerickson@nuovations.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Message-ID: <C52F13C5.1292C%gerickson@nuovations.com>
In-Reply-To: <20081030100353.240e795b@zod.rchland.ibm.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/30/08 7:03 AM, Josh Boyer wrote:
> On Wed, 29 Oct 2008 14:41:14 -0700
> Grant Erickson <gerickson@nuovations.com> wrote:
>> If the size of RAM is not an exact power of two, we may not have
>> covered RAM in its entirety with large 16 and 4 MiB
>> pages. Consequently, restrict the top end of RAM currently allocable
>> by updating '__initial_memory_limit_addr' so that calls to the LMB to
>> allocate PTEs for "tail" coverage with normal-sized pages (or other
>> reasons) do not attempt to allocate outside the allowed range.
> 
> Nice catch.  I was looking to see if 44x had the same problem, but I
> don't think it does because we simply over-map DRAM there.  Does that
> seem correct to you, or am I missing something on 44x that would cause
> this same problem?

Josh,

Because I do not have 44x hardware to validate against and because this
particular fix was localized to the 40x path, I did not take the time to
walk through the 44x path.

Regards,

Grant
