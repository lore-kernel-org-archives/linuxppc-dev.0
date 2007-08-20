Return-Path: <j.borkhuis@dutchspace.nl>
Received: from kirk.dutchspace.nl (kirk.dutchspace.nl [193.200.147.14])
	by ozlabs.org (Postfix) with ESMTP id 6AB6FDDE30
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Aug 2007 18:45:34 +1000 (EST)
Message-ID: <46C954AA.7050609@dutchspace.nl>
Date: Mon, 20 Aug 2007 10:45:30 +0200
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: Konstantin Boyanov <kkboyanov@gmail.com>
Subject: Re: Driver for device behind a PCI-VME bridge
References: <929bf310708200140w6efc57f6k81a1339845059e2d@mail.gmail.com>
In-Reply-To: <929bf310708200140w6efc57f6k81a1339845059e2d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Konstantin,

Konstantin Boyanov wrote:
> Hi list,
>
> I'm currently reading the LDD 3rd Edition and trying to create a 
> device driver for a custom device located on VME bus. I have already 
> linux 2.6.15 running on the master board, as well as the device driver 
> for the PCI-VME bridge. The main problem I have is understanding how 
> to "attach" my driver for the custom device to the bridge device driver.
> The bridge device driver is implemented as a class, i.e. doesn't 
> define a new bus type. Should I define a new class for my driver, or 
> should I connect it somehow to the existing one (maybe by something as 
> "subclass")?
> All I want to do is to redirect I/O reads and writes to the VME bus, 
> but I got no clue as to how to use the existing VME bridge driver for 
> this purpose. After I get through this I think all other things (VME 
> interrupt registration & handling, etc.) will be straightforward.
> The LDD 3rd book states that defining a new bus type is the last thing 
> one would like to do, instead defining a class is far better approach. 
> Why is that?
>
> Any recommendations and sharing of practical experience are highly 
> appreciated.
I am also working on a VME-board. What I did was use mmap to map 
specific parts of the VME-memory into user space.

BTW: what kind of board and Linux-flavor are you using?

Kind regards,
    Johan Borkhuis
