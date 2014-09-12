Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF6961A013A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Sep 2014 00:12:27 +1000 (EST)
Message-ID: <5412FF45.30208@suse.cz>
Date: Fri, 12 Sep 2014 16:12:21 +0200
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Ben Hutchings <ben@decadent.org.uk>, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v2] deb-pkg: Add support for powerpc little endian
References: <1409894927.11359.26.camel@ale.ozlabs.ibm.com>	
 <20140905071344.GA16024@visitor2.iram.es>	
 <1409903718.11359.30.camel@ale.ozlabs.ibm.com>	
 <20140905120925.GB3846@oc0268524204.ibm.com>
 <1410057728.7389.24.camel@decadent.org.uk>
In-Reply-To: <1410057728.7389.24.camel@decadent.org.uk>
Content-Type: text/plain; charset=utf-8
Cc: linux-kbuild@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Leann Ogasawara <leann.ogasawara@canonical.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014-09-07 04:42, Ben Hutchings wrote:
> On Fri, 2014-09-05 at 09:09 -0300, Thadeu Lima de Souza Cascardo wrote:
>> On Fri, Sep 05, 2014 at 05:55:18PM +1000, Michael Neuling wrote:
>>> On Fri, 2014-09-05 at 09:13 +0200, Gabriel Paubert wrote:
>>>> On Fri, Sep 05, 2014 at 03:28:47PM +1000, Michael Neuling wrote:
>>>>> The Debian powerpc little endian architecture is called ppc64le.  This
>>>>
>>>> Huh? ppc64le or ppc64el?
>>>
>>> ppc64el.  Commit message is wrong.  Fixed below.
>>>
>>> Mikey
>>>
>>>
>>
>> What about ppc64?
>>
>> Also, I sent that already a month ago. Both linuxppc-dev and Michal
>> Marek were on cc.
>>
>> http://marc.info/?l=linux-kernel&m=140744360328562&w=2
> 
> Anyone using powerpc (32-bit) will then need to add ppc64 as a foreign
> architecture before they can install a 64-bit custom kernel.  This is
> fine in principle, except that ppc64 is not an official Debian port and
> its packages are not mirrored on the same servers.
[...]
> So I think Michael's version, leaving big-endian kernels as powerpc by
> default, is preferable for now.

I applied v2 of Michael's patch to kbuild.git#misc.

Michal
