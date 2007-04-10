Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <16327e0d9602022d7ee57670ac23c383@kernel.crashing.org>
References: <20070410111324.GA2957@localhost.localdomain>
	<16327e0d9602022d7ee57670ac23c383@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4FDD7344-D9AD-4DCF-8C10-E65B6CEC7762@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 1/3] powerpc: delete -mstring option
Date: Tue, 10 Apr 2007 13:42:15 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Akinobu Mita <mita@fixstars.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 10, 2007, at 7:47 AM, Segher Boessenkool wrote:

>> There is no reason to force -mstring option.
>> (Kumar, please see patch 2/3 for FSL_BOOKE temporary fix)
>
>> -ifndef CONFIG_FSL_BOOKE
>> -CFLAGS		+= -mstring
>> -endif
>
> [and from 2/3]
>
>> +ifeq ($(CONFIG_FSL_BOOKE),y)
>> +CFLAGS         += -mno-string
>> +endif
>
> This is the right solution, thank you for the patch.
> But please fold these two together so that you're not
> introducing a regression halfway the patch series.

I agree this looks good and merge patches 1/3 and 2/3 into a single  
patch.

- k
