Return-Path: <galak@kernel.crashing.org>
Message-Id: <2C1E461A-1909-4EF4-9699-23306FBBA869@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080520051054.GN22279@yookeroo.seuss>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 0/4] minor fixes for 2.6.26
Date: Tue, 20 May 2008 00:21:52 -0500
References: <1211136296-4572-1-git-send-email-galak@kernel.crashing.org>
	<0B367446-4628-4633-BF66-A0007BD9A98B@kernel.crashing.org>
	<18482.2082.900892.368978@cargo.ozlabs.ibm.com>
	<119050FE-2BF4-4A45-8723-7A08EF38B290@kernel.crashing.org>
	<20080520051054.GN22279@yookeroo.seuss>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 20, 2008, at 12:10 AM, David Gibson wrote:

> On Mon, May 19, 2008 at 11:52:31PM -0500, Kumar Gala wrote:
>>
>> On May 19, 2008, at 6:07 PM, Paul Mackerras wrote:
>>
>>> Kumar Gala writes:
>>>
>>>>> Kumar Gala (4):
>>>>>    lmb: Fix compile warning
>>>>>    [POWERPC] Remove generated files on make clean
>>>
>>> I think that adding zImage.* to clean-files is a bad idea, because  
>>> we
>>> have zImage.lds.S, zImage.coff.lds.S and zImage.ps3.lds.S in
>>> arch/powerpc/boot that we don't want deleted.  It would be OK for
>>> compiling with a separate object directory but would be bad for
>>> compiling in the source directory.
>>
>> We already had them in clean-files:
>>
>> clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
>>                empty.c zImage zImage.coff.lds zImage.ps3.lds  
>> zImage.lds
>
> Not quite.  Those are the zImage.lds files, Paul is talking about the
> zImage.lds.S files from which the former are generated.

Ah, missed that minor detail.

- k
