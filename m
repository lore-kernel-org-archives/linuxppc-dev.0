Return-Path: <B04825@freescale.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Aggrwal Poonam-B10812 <B10812@freescale.com>
Subject: Re: [PATCH] Device Tree Bindings for Freescale TDM controller
Date: Sat, 17 Mar 2012 16:04:54 +0000
Message-ID: <CAOZdJXVVGOwDBAEaWzJwynvrqBgYD-qE-FiFgyPwEfTX5su9Pg@mail.gmail.com>
References: <1331861451-15427-1-git-send-email-poonam.aggrwal@freescale.com>
 <4F63868D.1030507@freescale.com>
 <ACB6D0C0104CFF42A45A5D82A0DD4F3D09D518@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <ACB6D0C0104CFF42A45A5D82A0DD4F3D09D518@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 17, 2012 at 2:33 AM, Aggrwal Poonam-B10812
<B10812@freescale.com> wrote:
>
>> > + =A0- clock-frequency
>> > + =A0 =A0 =A0Usage: optional
>> > + =A0 =A0 =A0Value type: <u32>
>> > + =A0 =A0 =A0Definition: The frequency at which the TDM block is opera=
ting.
>>
>> Will this frequency ever need to be > 4GHz?
> Don't think so, at max this will be CCB, not sure if CCB on our platforms=
 may get bigger than 4G ever.

Apparently, 4GB is the new 640K.

In Poonam's defense, every clock frequency property in the device tree
is a 32-bit integer.  I've never seen a 64-bit one.

--=20
Timur Tabi
Linux kernel developer at Freescale=
