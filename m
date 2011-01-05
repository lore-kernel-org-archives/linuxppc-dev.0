Return-Path: <Hollis_Blanchard@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
Date: Wed, 5 Jan 2011 14:49:40 -0800
Message-ID: <DD7A9A95166BF4418C4C1EB2033B6EE2038FA8E4@na3-mail.mgc.mentorg.com>
In-Reply-To: <20110105160918.2b530fea@udp111988uds.am.freescale.net>
References: <4D12F171.7010103@mentor.com>	<20101223185623.GA20384@angua.secretlab.ca>	<4D13C402.2090209@mentor.com>	<20101223223325.GK20384@angua.secretlab.ca>	<20110103135120.32aeb60d@udp111988uds.am.freescale.net>	<4D24E99F.90908@mentor.com>
	<20110105160918.2b530fea@udp111988uds.am.freescale.net>
From: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: "Inge, Meador" <meador_inge@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/05/2011 02:09 PM, Scott Wood wrote:
> On Wed, 5 Jan 2011 15:58:55 -0600
> Meador Inge<meador_inge@mentor.com>  wrote:
>
>> We need some sort of mapping between a message register and a message
>> register number so that the message registers can be referenced =
through
>> some sort of API (e.g. 'mpic_msgr_read(0)').  One way to do that =
would
>> be by putting an order on the registers.  Maybe there is a better =
way,
>> though ...
> A message register is uniquely identified by a reference to the device
> tree node, plus a 0-3 index into that node's message registers.
Really what we're talking about is software configuration, not hardware=20
description. We've gone back and forth on representing this information=20
in the device tree, and most recently decided against it. Outside the=20
kernel, a device node reference isn't really practical.

Hollis Blanchard
Mentor Graphics, Embedded Systems Division
