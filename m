Return-Path: <Hollis_Blanchard@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay1.mentorg.com",
	Issuer "Entrust Certification Authority - L1B" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8F660B6F15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 May 2011 06:22:37 +1000 (EST)
Message-ID: <4DC84D09.5020909@mentor.com>
Date: Mon, 09 May 2011 13:22:33 -0700
From: Hollis Blanchard <hollis_blanchard@mentor.com>
MIME-Version: 1.0
To: Prasanna Khanapur <pskhanapur@googlemail.com>
Subject: Re: Regarding P2020 in AMP mode
References: <BANLkTik7tZSJ9-OPDbQEPJDHpZ13wMmo_Q@mail.gmail.com>
In-Reply-To: <BANLkTik7tZSJ9-OPDbQEPJDHpZ13wMmo_Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/2011 05:20 AM, Prasanna Khanapur wrote:
> Hi,
> I'm running P2020 in AMP mode, each core running its linux os.
> Ethernet 1(@25000) and Ethernet 2(@26000) assigned to Core0 are working
> fine.
> I'm facing problems with Ethernet interface(@24000) assigned to Core1,
> its not working.
>
> I'm using dts file which were added by :
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-September/075594.html
>
> Looks either there is some mistake in the dts file or my understanding
> is wrong.
>
> MDIO @24000 is defined in core0 dts file though the Ethernet is assigned
> to Core 1.
>
> DTS files :
> http://web.mornfall.net/repos/linux-2.6/git/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
> http://web.mornfall.net/repos/linux-2.6/git/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts

The fixed-link property in core1.dts indicates enet0 should use 1Gb 
link. Is that device connected to a 1Gb network?

-- 
Hollis Blanchard
Mentor Graphics, Embedded Systems Division
