Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <989B956029373F45A0B8AF0297081890019B5C7A@zch01exm26.fsl.freescale.net>
References: <1192702580-6353-1-git-send-email-leoli@freescale.com>
	<20071019005613.GA18240@localhost.localdomain>
	<989B956029373F45A0B8AF0297081890019B5C7A@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DB820C38-6CE5-4A7A-BC29-6E528CD3F061@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v5 9/9] add MPC837x MDS board default device tree
Date: Fri, 19 Oct 2007 08:10:50 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	paulus@samba.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 19, 2007, at 2:31 AM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: David Gibson [mailto:david@gibson.dropbear.id.au]
>> Sent: Friday, October 19, 2007 8:56 AM
>> To: Li Yang-r58472
>> Cc: galak@kernel.crashing.org; paulus@samba.org;
>> linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH v5 9/9] add MPC837x MDS board default device tree
>>
>> On Thu, Oct 18, 2007 at 06:16:20PM +0800, Li Yang wrote:
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> ---
>>> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts
>>> b/arch/powerpc/boot/dts/mpc8377_mds.dts
>>> new file mode 100644
>>> index 0000000..8530de6
>>> --- /dev/null
>>> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
>>> @@ -0,0 +1,282 @@
>> [snip]
>>> +		crypto@30000 {
>>> +			model = "SEC3";
>>> +			compatible = "talitos";
>>
>> That compatible doesn't look specific enough.  It should at
>> least have a vendor portion.  In general it's best to have
>> all the information you need to pick a driver and options in
>> compatible, rather than splitting that info into model.
>
> I think we could do this in a separate patch.  Change the spec and  
> then
> update all the in-tree device tree with SEC node.

agreed.

- k
