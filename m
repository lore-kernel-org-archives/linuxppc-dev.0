Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D0096DE182
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 03:48:44 +1000 (EST)
Date: Tue, 15 Jul 2008 21:48:43 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: add FHCI USB, FSL MCU, FSL UPM and GPIO
	LEDs bindings
Message-ID: <20080715174843.GA6336@polina.dev.rtsoft.ru>
References: <20080703174844.GA27966@polina.dev.rtsoft.ru>
	<EC062FA3-9CF8-4A94-95C7-2AAF22754A9C@kernel.crashing.org>
	<20080703182440.GA2576@polina.dev.rtsoft.ru>
	<8A8D87F8-A1DD-467D-8D83-CDC651B99F45@kernel.crashing.org>
	<20080704165328.GA9962@polina.dev.rtsoft.ru>
	<C3A1E950-3D5F-4172-90B6-1566D4A70B7C@kernel.crashing.org>
	<20080715161053.GA9356@polina.dev.rtsoft.ru>
	<9340606A-7A87-4475-A133-81F5B59C7960@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <9340606A-7A87-4475-A133-81F5B59C7960@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 11:23:42AM -0500, Kumar Gala wrote:
>>>
>> Ugh, you fixed bindings' directory in Jochen's CPM patch, but not in
>> my patch:
>>
>> commit 91993d56812fd09b6cccea12d3c83df623cb0ea6
>> Author: Anton Vorontsov <avorontsov@ru.mvista.com>
>> Date:   Fri Jul 4 20:53:28 2008 +0400
>>
>>    powerpc: add FHCI USB, FSL MCU, FSL UPM and GPIO LEDs bindings
>>
>>    This patch adds few bindings for the new drivers to be submitted  
>> through
>>    the appropriate maintainers.
>>
>>    Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>>    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>>
>> diff --git a/Documentation/powerpc/device-tree/fsl/mcu- 
>> mpc8349emitx.txt b/Documentation/powerpc/device-tree/fsl/mcu- 
>> mpc8349emit
>> new file mode 100644
>> index 0000000..0f76633
>> --- /dev/null
>> +++ b/Documentation/powerpc/device-tree/fsl/mcu-mpc8349emitx.txt
>> ....
>
> Rebased the tree and fixed it.  Can you look over the files and make  
> sure everything looks ok.  (I'm partially concerned about the QE usb  
> node).

Yes, everything looks fine. b-w-of specified old QE USB bindings,
and no single driver actually used them.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
