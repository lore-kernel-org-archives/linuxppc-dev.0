Return-Path: <galak@kernel.crashing.org>
Message-Id: <A7BF6E08-786A-4D00-BBEA-1568939722E9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Morrison, Tom" <tmorrison@empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D9010F59452A@EMPBEDEX.empirix.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: MPC8572 - IPR Register
Date: Tue, 16 Dec 2008 15:34:31 -0600
References: <mailman.2123.1229452170.29923.linuxppc-dev@ozlabs.org>
	<BD261180E6D35F4D9D32F3E44FD3D9010F59452A@EMPBEDEX.empirix.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 16, 2008, at 1:54 PM, Morrison, Tom wrote:

> We are having a problem with an external interrupt not actually being
> received / detected on the MPC8572.
>
> This external device 'believes' that it has sent an interrupt
> (over PCIe) to the MPC8572 and we believe that the associated
> ExVPR register has correctly unmasked/configured this correctly.
>
> But, still NO interrupt...
>
> If you read the documentation about this configuration register, it
> indicates that there is some type of "IPR" register internal to the
> 8572 that indicates if an interrupt has been received by the PIC...
>
> We want to read that IPR register to verify that:
>   a) the external device has sent the interrupt
> 	and we have configured something wrong in the chip
>
>   b) there is no pending interrupt (thus none received) from
> 	this external device...
>
> Is there any way (hook (indirection) or crook (aka: secret register))
> that would allow us to read this register? From all my investigations
> it looks like there isn't a 'straight forward' / documented way to
> do so...I am hoping you guys have gone beyond the 'straight forward'
> means and have found a way...
>
> Thanks in Advance...

1. Which PCIe port is the device on?
2. is this a INT-X style or MSI interrupt?
3. if INT-X is INT-A, B, C, D?

- k
