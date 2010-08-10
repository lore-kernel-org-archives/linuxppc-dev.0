Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <F9BD3E0A8083BE4ABAA94D7EDD7E3F631093B6@zch01exm26.fsl.freescale.net>
References: <AANLkTimm7G--LQHYBqPB1YCXQb7fSXPDaYsLq0p30DG1@mail.gmail.com>
	<F9BD3E0A8083BE4ABAA94D7EDD7E3F63109216@zch01exm26.fsl.freescale.net>
	<AANLkTi=3MQBSd_phbSZnRA-wFB7cfa4U_PKND+BgZVhd@mail.gmail.com>
	<F9BD3E0A8083BE4ABAA94D7EDD7E3F6310925F@zch01exm26.fsl.freescale.net>
	<AANLkTinQnFBcLiDyQtRRwzdAg_M48BnNsa2OyKWCiSUh@mail.gmail.com>
	<F9BD3E0A8083BE4ABAA94D7EDD7E3F631093B6@zch01exm26.fsl.freescale.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 9 Aug 2010 23:04:16 -0600
Message-ID: <AANLkTin2C2B61WDU-c+rcdsfCKE4MKAwnaVeDCCx5CYK@mail.gmail.com>
Subject: Re: Review Request: New proposal for device tree clock binding.
To: Li Yang-R58472 <r58472@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 9, 2010 at 10:56 PM, Li Yang-R58472 <r58472@freescale.com> wrot=
e:
>>>> I've avoided requiring clock nodes to have a separate sub node for
>>>> each output because it is more verbose and it prevents clock
>>>> providers from having child nodes for other purposes. =A0Are you
>>>> concerned that
>>>
>>> I don't see why there should be child nodes for other purposes under
>>clock node.
>>>
>>>> having the <phandle>+output name pair will be difficult to manage?
>>>
>>> That's part of my concern.
>>
>>I was concerned about this too until I found precedence for doing the
>>exact same thing in the pci binding (and ePAPR). =A0Mixing phandle and a
>>string in this way doesn't bother me anymore.
>
> Where exactly can I get the sample code for handling this binding?

In my test-devicetree branch.  See the file drivers/of/clock.c[1] from
commit [2]:

[1] http://git.secretlab.ca/?p=3Dlinux-2.6.git;a=3Dblob;f=3Ddrivers/of/cloc=
k.c;h=3D26bd70c293d3ec23cbef3f67e0853069b6c24dc0;hb=3Dfadbfb859485148756533=
b28203b7b0188a17250
[2] http://git.secretlab.ca/?p=3Dlinux-2.6.git;a=3Dcommit;h=3Dfadbfb8594851=
48756533b28203b7b0188a17250

g.
