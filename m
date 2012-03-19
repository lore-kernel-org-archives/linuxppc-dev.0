Return-Path: <B07421@freescale.com>
Message-ID: <4F676C9D.2070301@freescale.com>
Date: Mon, 19 Mar 2012 12:27:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] Device Tree Bindings for Freescale TDM controller
References: <1331861451-15427-1-git-send-email-poonam.aggrwal@freescale.com>
 <4F63868D.1030507@freescale.com>
 <ACB6D0C0104CFF42A45A5D82A0DD4F3D09D518@039-SN2MPN1-013.039d.mgd.msft.net>
 <CAOZdJXVU=1bW8_OTMecJHuWaa6_023UnUsfQTX8MGqd3E4SRAg@mail.gmail.com>
In-Reply-To: <CAOZdJXVU=1bW8_OTMecJHuWaa6_023UnUsfQTX8MGqd3E4SRAg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
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

On 03/17/2012 11:07 AM, Tabi Timur-B04825 wrote:
> On Sat, Mar 17, 2012 at 2:33 AM, Aggrwal Poonam-B10812
> <B10812@freescale.com> wrote:
>>
>>>> +           compatible = "fsl,p1010-tdm", "fsl,mpc8315-tdm";
>>>> +           reg = <0x16000 0x200 0x2c000 0x2000>;
>>>> +           clock-frequency = <0>;
>>>
>>> Show a real clock-frequency, perhaps with a comment saying it's typically
>>> filled in by boot software.
> 
>> Okay.
> 
> Scott, are you suggesting that Poonam put a non-zero number in the DTS
> for clock-frequency?  If so, then I don't think that's a good idea, if
> U-Boot will always override it.

This is a device tree binding document, not U-Boot specific.  It
describes what Linux (or another OS) can expect to see, not how it gets
there.

-Scott
