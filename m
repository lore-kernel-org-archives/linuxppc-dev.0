Return-Path: <galak@kernel.crashing.org>
Message-Id: <E9E24C93-F147-49F0-9FBE-FCE4883D11BF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <49DC515F.3040100@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v3 0/5] i2c: i2c-mpc: make I2C bus speed configurable
Date: Wed, 8 Apr 2009 10:21:12 -0500
References: <20090407082052.477328750@denx.de>
	<53B42D49-C040-442E-8448-7BC3190220A5@kernel.crashing.org>
	<F4E3E1FF-C544-460A-AC27-DB9501C13ED3@kernel.crashing.org>
	<49DC515F.3040100@grandegger.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@ozlabs.org>,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 8, 2009, at 2:25 AM, Wolfgang Grandegger wrote:

>> So I'm a bit concerned with the output we now get:
>>
>> mpc-i2c fffe03000.i2c: clock 0 Hz (dfsrr=16 fdr=49)
>>
>> why 0? is that right?
>
> This is the backward compatibility mode using hard-coded FDR values.  
> The
> output is missleading, I agree.
>
> Wolfgang.

Can the output be fixed.  0 Hz seemed bad to me.

- k
