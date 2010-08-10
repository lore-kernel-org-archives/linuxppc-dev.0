Return-Path: <R58472@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Subject: RE: Review Request: New proposal for device tree clock binding.
Date: Tue, 10 Aug 2010 12:56:24 +0800
Message-ID: <F9BD3E0A8083BE4ABAA94D7EDD7E3F631093B6@zch01exm26.fsl.freescale.net>
In-Reply-To: <AANLkTinQnFBcLiDyQtRRwzdAg_M48BnNsa2OyKWCiSUh@mail.gmail.com>
References: <AANLkTimm7G--LQHYBqPB1YCXQb7fSXPDaYsLq0p30DG1@mail.gmail.com>
	<F9BD3E0A8083BE4ABAA94D7EDD7E3F63109216@zch01exm26.fsl.freescale.net>
	<AANLkTi=3MQBSd_phbSZnRA-wFB7cfa4U_PKND+BgZVhd@mail.gmail.com>
	<F9BD3E0A8083BE4ABAA94D7EDD7E3F6310925F@zch01exm26.fsl.freescale.net>
	<AANLkTinQnFBcLiDyQtRRwzdAg_M48BnNsa2OyKWCiSUh@mail.gmail.com>
From: Li Yang-R58472 <r58472@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
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

>>> I've avoided requiring clock nodes to have a separate sub node for
>>> each output because it is more verbose and it prevents clock
>>> providers from having child nodes for other purposes. =A0Are you
>>> concerned that
>>
>> I don't see why there should be child nodes for other purposes under
>clock node.
>>
>>> having the <phandle>+output name pair will be difficult to manage?
>>
>> That's part of my concern.
>
>I was concerned about this too until I found precedence for doing the
>exact same thing in the pci binding (and ePAPR).  Mixing phandle and a
>string in this way doesn't bother me anymore.

Where exactly can I get the sample code for handling this binding?

- Leo
