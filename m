Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: zjzhou@newrocktech.com
Message-ID: <2432.221.137.49.91.1077963761.squirrel@mail.newrocktech.com>
In-Reply-To: <403F6E60.1010404@euronet.nl>
References: <903E17B6FF22A24C96B4E28C2C0214D70146BE7E@SR-BNG-EXC01.fci.com>
     <403F6E60.1010404@euronet.nl>
Date: Sat, 28 Feb 2004 18:22:41 +0800 (CST)
Subject: about MPC852T board
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear All,

I know the board based on mpc852T supported by ELDK3.0 are AdderII and
MPC86xADS.

Could you tell me which boards based on MPC852T are supported by ELDK3.0
except AdderII and MPC86xADS?

Thanks in advance!
John

> Hegde, Ashok wrote:
>
>> I want to test my serial driver at higher speeds, How to test serial
>> data transfer up to 1.5Mbps speed. Is it zmodem protocol supports
>> this speed? I am able to test it (using zmodem protocol )up to 115K,
>> beyond this I am facing problem.
>
> You mentioned 115k2, probably an async port. Do you want to run async
> at 1,5mbit/s? What kind of device will that be? I think the zmodem
> protocol does not mind to be used at higher rates :o) Your problem is
> probably somewhere else. (drivers?)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
