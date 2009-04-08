Return-Path: <galak@kernel.crashing.org>
Message-Id: <5FDB097C-7D71-41DF-A4F4-2DE34FD710C5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40904072216m64b4fd83q9b52c89ae40cae11@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v3 0/5] i2c: i2c-mpc: make I2C bus speed configurable
Date: Wed, 8 Apr 2009 00:22:29 -0500
References: <20090407082052.477328750@denx.de>
	<53B42D49-C040-442E-8448-7BC3190220A5@kernel.crashing.org>
	<fa686aa40904072216m64b4fd83q9b52c89ae40cae11@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 8, 2009, at 12:16 AM, Grant Likely wrote:

> On Tue, Apr 7, 2009 at 10:11 PM, Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>> On Apr 7, 2009, at 3:20 AM, Wolfgang Grandegger wrote:
>>
>>> This patch series makes the I2C bus speed configurable by using the
>>> I2C node property "clock-frequency". If the property is not defined,
>>> the old fixed clock settings will be used for backward  
>>> compatibility.
>>> The property "fsl,preserve-clocking" allows to inherit the settings
>>> from the bootloader. Furthermore, it does some cleanup and uses the
>>> new bindings for the Socrates board:
>>>
>>>  i2c: i2c-mpc: various coding style fixes
>>>  i2c: i2c-mpc: use dev based printout function
>>>  i2c: i2c-mpc: make I2C bus speed configurable
>>
>> It looks like Ben picked up these patches.
>>
>>>  powerpc: i2c-mpc: document new FSL I2C bindings and cleanup
>>>  powerpc/85xx: i2c-mpc: use new I2C bindings for the Socates board
>>
>> I would have preferred these two go via me, but it looks like the  
>> board one
>> got picked up by Ben.  I'll deal with the doc/binding update.
>
> hrummm.  As I mentioned in my reply, I'm not convinced that the board
> one is the right thing in this case.  I would have preferred it to be
> deferred.

which part?  I missed this whole thread as I had it forwarding to my  
devicetree-discuss folder which I don't normally look at.

- k
