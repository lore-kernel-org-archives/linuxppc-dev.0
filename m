Date: Fri, 28 Jul 2000 10:40:39 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Cyprien LAPLACE <cyprien.laplace@fnac.net>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: UniverseII driver
In-Reply-To: <20000727205624.4408F11724@www.multimania.com>
Message-ID: <Pine.HPX.4.10.10007281035440.11700-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 27 Jul 2000, Cyprien LAPLACE wrote:

>
> 	hello,
>
>
> i would know if someone has a Universe II driver..
>
> for a MVME2600 borad (PPC603ev)

as mentioned by Gong there is my driver at ftp://vlab1.iram.es, I'd
recommend the one under the linux-2.2 direcctory) for now (but take the
include fil and examples from the linux-vme directory). It was developped,
as well as a bunch of other patches including an improved bootloader on an
MVME2603 (200MHz 603ev) and includes a lot.

The 2.4 version is not yet ready (close) and I have time to work on the
doc in August. In the meantime contact me privately (in French, Spanish or
English, that's up to you) for details if you have problems. Have a look
at the examples, they are very useful if you want to write an additional
kernel module for a specfific board.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
