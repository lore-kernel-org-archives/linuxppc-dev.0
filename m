Return-Path: <markos@codex.gr>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: GPIO - marking individual pins (not) available in device tree
MIME-Version: 1.0
Date: Tue, 28 Oct 2008 14:31:29 +0100
From: Konstantinos Margaritis <markos@codex.gr>
Message-ID: <7b6eafc46f644dea59fbf0af17dbc005@localhost>
Content-Type: text/plain; charset="UTF-8"
Cc: Mitch Bradley <wmb@firmworks.com>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Pardon my intrusion in the conversation, but I just couldn't not comment on
this:

On Tue, 28 Oct 2008 12:50:03 +1100, David Gibson
<david@gibson.dropbear.id.au> wrote:
>> So now my qualm is back to the beginning of the discussion. How do
>> we encode the purpose of those pins reliably and within some
>> standard framework, without getting *driver* specific?
>
> Um.. I fail to see how the purpose of a pin can be not driver
> specific.

GPIO stands for _General_ Purpose IO. The driver should just expose that
info to user space and it should be up to the userspace application to
decide what to do with that. The programmer should require absolutely
no other intervention to the driver whatsoever.
Anyone that has worked on data mining scientific equipment -eg.
particle/photon scanners on VME boards with lots of GPIO pins- will tell
you that meddling with kernel coding is totally unneeded, in fact it's
stupid to require the student to do so. Usually some Windows API is given
and the students write the programs on Windows to collect the data and
control the device. I guess GPIOLIB and the new framework would have
similar application in Linux -ie, requiring the programmer to write only
a userspace to access the GPIO pins. From my understanding of the
conversation, there are some people who fail to see the necessity of
doing extra work to abstract this information away from the driver. A walk
to a nearby experimental physicists lab with students working on such
devices will convince you of the right way to do it actually.

PS. I am of physics background myself, though a theoritical one and not 
experimental. But I did have many friends experimentalists, in
particular I remember two that did exactly what I described. Neither did
have any particular kernel/driver knowledge and neither did have to do
anything extremely low-level to acquire the data. Both used windows 
user-level programming, though that was ~8years ago so don't expect me
to remember the exact VME boards or APIs used...

Konstantinos Margaritis
Codex
http://www.codex.gr
