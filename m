Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <5FDB097C-7D71-41DF-A4F4-2DE34FD710C5@kernel.crashing.org>
References: <20090407082052.477328750@denx.de>
	<53B42D49-C040-442E-8448-7BC3190220A5@kernel.crashing.org>
	<fa686aa40904072216m64b4fd83q9b52c89ae40cae11@mail.gmail.com>
	<5FDB097C-7D71-41DF-A4F4-2DE34FD710C5@kernel.crashing.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 7 Apr 2009 22:32:28 -0700
Message-ID: <fa686aa40904072232vb5185deu4216964050dd895f@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] i2c: i2c-mpc: make I2C bus speed configurable
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On Tue, Apr 7, 2009 at 10:22 PM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
>
> On Apr 8, 2009, at 12:16 AM, Grant Likely wrote:
>
>> On Tue, Apr 7, 2009 at 10:11 PM, Kumar Gala <galak@kernel.crashing.org>
>> wrote:
>>>
>>> On Apr 7, 2009, at 3:20 AM, Wolfgang Grandegger wrote:
>>>
>>>> This patch series makes the I2C bus speed configurable by using the
>>>> I2C node property "clock-frequency". If the property is not defined,
>>>> the old fixed clock settings will be used for backward compatibility.
>>>> The property "fsl,preserve-clocking" allows to inherit the settings
>>>> from the bootloader. Furthermore, it does some cleanup and uses the
>>>> new bindings for the Socrates board:
>>>>
>>>> =A0i2c: i2c-mpc: various coding style fixes
>>>> =A0i2c: i2c-mpc: use dev based printout function
>>>> =A0i2c: i2c-mpc: make I2C bus speed configurable
>>>
>>> It looks like Ben picked up these patches.
>>>
>>>> =A0powerpc: i2c-mpc: document new FSL I2C bindings and cleanup
>>>> =A0powerpc/85xx: i2c-mpc: use new I2C bindings for the Socates board
>>>
>>> I would have preferred these two go via me, but it looks like the board
>>> one
>>> got picked up by Ben. =A0I'll deal with the doc/binding update.
>>
>> hrummm. =A0As I mentioned in my reply, I'm not convinced that the board
>> one is the right thing in this case. =A0I would have preferred it to be
>> deferred.
>
> which part? =A0I missed this whole thread as I had it forwarding to my
> devicetree-discuss folder which I don't normally look at.

Here you go:

On Tue, Apr 7, 2009 at 8:43 AM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Tue, Apr 7, 2009 at 1:20 AM, Wolfgang Grandegger <wg@grandegger.com> w=
rote:
>> Preserve I2C clock settings for the Socrates MPC8544 board.
>
> I had thought that the preserve-clocking property was intended for
> older boards that don't currently have any method of getting the clock
> setting out of u-boot.  Since Socrates is a new board, U-Boot should
> probably be made to fill in the real clock rate setting.
>
> g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
