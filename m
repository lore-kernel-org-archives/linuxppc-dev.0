Return-Path: <sudeep.holla@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id A85552C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 23:03:56 +1100 (EST)
Message-ID: <532C2ACD.7070107@arm.com>
Date: Fri, 21 Mar 2014 12:04:29 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC/RFT v3 6/9] powerpc: move cacheinfo sysfs to generic
 cacheinfo infrastructure
References: <1392825976-17633-1-git-send-email-sudeep.holla@arm.com>
 <1392825976-17633-7-git-send-email-sudeep.holla@arm.com>
 <531945D1.7010503@linux.vnet.ibm.com> <531963D9.5040701@linux.vnet.ibm.com>
 <531D9E3A.7040109@arm.com> <532BB5AC.3000904@linux.vnet.ibm.com>
In-Reply-To: <532BB5AC.3000904@linux.vnet.ibm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anshuman,

On 21/03/14 03:44, Anshuman Khandual wrote:
> On 03/10/2014 04:42 PM, Sudeep Holla wrote:
>> Hi Anshuman,
>>
>> On 07/03/14 06:14, Anshuman Khandual wrote:
>>> On 03/07/2014 09:36 AM, Anshuman Khandual wrote:
>>>> On 02/19/2014 09:36 PM, Sudeep Holla wrote:
>>>>> From: Sudeep Holla <sudeep.holla@arm.com>
>>>>>
>>>>> This patch removes the redundant sysfs cacheinfo code by making use o=
f
>>>>> the newly introduced generic cacheinfo infrastructure.

[...]

>>>> When it is UNIFIED we return index 0, which is correct. But the index
>>>> for instruction and data cache seems to be swapped which wrong. This
>>>> will fetch invalid properties for any given cache type.
>>>>
>>
>> Ah, that's silly mistake on my side, will fix it.
>>
>>>> I have done some initial review and testing for this patch's impact on
>>>> PowerPC (ppc64 POWER specifically). I am trying to do some code clean-=
up
>>>> and re-arrangements. Will post out soon. Thanks !
>>
>> Thanks for taking time for testing and reviewing these patches.
>=20
> Now that you got some of the problems to work on and resend the patches, =
I will
> hold on to the clean up patches I had.
>=20

I have done most of the changes but still unable to find why the shared_cpu=
_map
is getting incorrect on PPC. All the other wrong entries are fixed. Any clu=
e on
shared_cpu_map ?

Regards,
Sudeep
