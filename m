Return-Path: <JOFT@gmx.de>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by ozlabs.org (Postfix) with SMTP id AF985B6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 03:03:16 +1000 (EST)
Message-ID: <4DA485CD.6060604@gmx.de>
Date: Tue, 12 Apr 2011 19:03:09 +0200
From: =?ISO-8859-1?Q?Joachim_F=F6rster?= <JOFT@gmx.de>
MIME-Version: 1.0
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Where is CONFIG_BOOT_LOAD ?
References: <201104081128.37906.dargaud@lpsc.in2p3.fr>	<1302255741.5359.7.camel@flotop>
	<201104081458.43831.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201104081458.43831.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org,
	=?ISO-8859-1?Q?Florian_V=F6gel?= <fvoegel@partner.ime-actia.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/08/2011 02:58 PM, Guillaume Dargaud wrote:
>> Isn't that blackfin specific?
>
> So how do you change the loading address of the PowerPC kernel from its default 0x400000 address ?

Note that the default 0x400... is the link address of the zImage wrapper 
rather than the one of THE kernel.

Currently the link address seems to be hard-coded into
arch/powerpc/boot/wrapper
(a shell script). Since long ago I'm wondering why the maintainers did 
that. But I guess there is a reason, because it wasn't that way in the 
old arch/ppc days ;-) ...

Is configuring the zImage-piggy-back-loader through menuconfig & co evil?

   Joachim
