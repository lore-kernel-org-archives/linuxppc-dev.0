Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jerome Glisse <j.glisse@free.fr>
In-Reply-To: <41CDD97A.10702@free.fr>
References: <41CDD97A.10702@free.fr>
Content-Type: text/plain
Date: Sun, 26 Dec 2004 11:00:02 +0100
Message-Id: <1104055202.23891.10.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: G5 AGP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2004-12-25 at 22:19 +0100, Jerome Glisse wrote:
> Hi,
> 
> I am working on G5 agp uninorth and i am facing a strange problem.
> I have my agpworking but the change i made seems to broke the fan
> control, thus the fan start to go to their full speed shortly after i load
> my uninorth driver.
> 
> Is fan control related in anyway to PCI or AGP ? :)

No, that's weird. All fans are ramping up or only the backside one ?

You could enable the debug output in the fan driver...

> By the way i could not unload my module, kernel claim that is used
> by someone even if no one (no graphics card module loaded) any clue ?

Probably the AGP core
