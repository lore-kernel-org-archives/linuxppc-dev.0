Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 863691007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Jan 2011 14:27:58 +1100 (EST)
Message-ID: <4D3CF215.206@windriver.com>
Date: Mon, 24 Jan 2011 11:29:25 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: kevin diggs <diggskevin38@gmail.com>
Subject: Re: elf section .text.unlikely
References: <AANLkTimbZh5KCD2tT3rE5prhOBV9D_-QVdLyu0usmvMw@mail.gmail.com>	<AANLkTime0kT7rpVKvqZZ1uyib8GqBkgpQ6osDnfCrN0p@mail.gmail.com>
	<AANLkTinhu1fS5ESwivxSepnp-CXirm9dfV74_GEUi9qB@mail.gmail.com>
In-Reply-To: <AANLkTinhu1fS5ESwivxSepnp-CXirm9dfV74_GEUi9qB@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kevin diggs wrote:
> Hi,
> 
> One more thing:
> 
> The last message printed is:
> 
> Driver 'sd' needs updating - please us bus_type methods
> 
> The mesh SCSI controller seems to successfully scan the bus. The next
> message that a 3.4.6 compiled kernel prints are details about disk sda
> (from SCSI disk driver?).
> 
> 4.3.5 keyboard is dead.
> 
> Jog any thoughts?

Maybe the kernel already panic then serial cannot print the last messages
immediately. So after reset the target you can dump __log_buf from the u-boot
prompt to track this in detail.

Tiejun

> 
> Thanks!
> 
> kevin
> 
> On Fri, Jan 21, 2011 at 8:31 PM, kevin diggs <diggskevin38@gmail.com> wrote:
>> For what it is worth, this section contains dump_stack, panic, and printk
>>
>> Thanks!
>>
>> kevin
>>
>> On Fri, Jan 21, 2011 at 7:40 PM, kevin diggs <diggskevin38@gmail.com> wrote:
>>> Hi,
>>>
>>> I am trying to get a PowerMac 8600 to boot past 2.6.28.
>>>
>>> I can boot 2.6.28 compiled with either 3.3.3 or 3.4.6. I can't get
>>> 2.6.28 to boot using 4.3.5. The 4.3.5 vmlinux has a section
>>> '.text.unlikely' that the 3.4.6 version does not. Anyone know what
>>> this might be?
>>>
>>> kevin
