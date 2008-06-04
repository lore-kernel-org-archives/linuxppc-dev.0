Return-Path: <galak@kernel.crashing.org>
Message-Id: <02EC7209-F395-4C01-A445-E111E6E54A25@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <484663DB.5000905@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
Date: Wed, 4 Jun 2008 08:27:20 -0500
References: <1212130188-28835-1-git-send-email-wg@grandegger.com>
	<1212130188-28835-2-git-send-email-wg@grandegger.com>
	<20080602020352.GB19393@yookeroo.seuss>
	<479BA7CE-CD12-4935-87EB-E69025D408E6@kernel.crashing.org>
	<4845181E.8040603@grandegger.com>
	<07AEED44-7DEB-46C1-B028-3EFA274CEB11@kernel.crashing.org>
	<20080603223905.GA22982@yookeroo.seuss>
	<484663DB.5000905@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 4, 2008, at 4:43 AM, Wolfgang Grandegger wrote:

> David Gibson wrote:
>> On Tue, Jun 03, 2008 at 09:33:12AM -0500, Kumar Gala wrote:
>>> On Jun 3, 2008, at 5:08 AM, Wolfgang Grandegger wrote:
>>>> Kumar Gala wrote:
>>>>> On Jun 1, 2008, at 9:03 PM, David Gibson wrote:
>>>>>> On Fri, May 30, 2008 at 08:49:45AM +0200, Wolfgang Grandegger  
>>>>>> wrote:
>> [snip]
>>>>>> You have a whole lot of 'cell-index' properties through both  
>>>>>> these
>>>>>> trees, and they all look wrong.  cell-index is a hack, which
>>>>>> should be
>>>>>> avoided wherever practical - it should only be used when the  
>>>>>> index
>>>>>> is
>>>>>> used to offset into some global register block, never simply to
>>>>>> differentiate (use reg for that) or name the devices (use aliases
>>>>>> for
>>>>>> that).
>>>>> this is why FSL device tree's have cell-index.  We have global
>>>>> control
>>>>> registers that need to know such things.
>>>> Should I remove them or not? OF is still a mystery for me :-(.
>>> Don't remove them.
>>
>> Yes, they're ok, given this usage.
>
> I'm puzzled. Could someone point me to some real code where cell-index
> is used as a pointer into some global data. Sorry for my ignorance.

http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057254.html

- k
